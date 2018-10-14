class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:refresh_elo]
  
  include ApplicationHelper

  def show
    @user = User.find(params[:id])
    @posts = Post.where("user_id = ?", @user)
                 .order('created_at DESC')
                 .page(params[:page]).per(10)
  end

  def sync_elo
    return false unless current_user.lol_name

    if session[:last_sync].is_a? String
      session[:last_sync] = Time.parse(session[:last_sync])
    end

    session[:last_sync] ||= Time.now - 35.seconds
    if Time.now - session[:last_sync] < 30.seconds
      flash[:alert] = "Espere pelo menos 30s para sincronizar novamente!"
      redirect_to '/'
      return false
    end

    id, name = get_summoner_id_name(current_user.lol_name)
    tier, rank = get_tier_rank(id)

    current_user.lol_tier = tier
    current_user.lol_rank = rank

    if current_user.save
      session[:last_sync] = Time.now
      flash[:notice] = "Dados de '#{name}' atualizados!"
    else
      flash[:alert] = "Um erro inesperado aconteceu! Meu deus alguém avisa o ADM D:"
    end
    redirect_to '/'
  end
end
