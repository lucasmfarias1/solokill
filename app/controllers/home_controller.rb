class HomeController < ApplicationController
  protect_from_forgery prepend: true
  before_action :authenticate_user!
  include ApplicationHelper
  def index
    if params[:filter]
      filter = params[:filter]
    else
      filter = ''
    end
    if filter != ''
      @posts = Post.joins(:user).where('users.lol_tier = ?',
                                       filter)
                                .order('created_at DESC')
    else
      @posts = Post.all.order('created_at DESC')
    end

    # Post.joins(:user).where('users.lol_tier = ?', "DIAMOND")

    if current_user.lol_verification_key
      @code = current_user.lol_verification_key
    else
      current_user.lol_verification_key = generate_key
      current_user.save
      @code = current_user.lol_verification_key
    end


  end

  def new_post
    @post = Post.new
    @post.user = current_user
    @post.content = params[:post][:content]

    respond_to do |format|
      if @post.save
        format.html { redirect_back fallback_location: '/', notice: 'Posted!' }
        format.js
      else
        format.html { redirect_back fallback_location: '/', notice: 'Failed!' }
        format.js
      end
    end
  end

  def verify
    name = params[:summoner_name]
    id, real_name = get_summoner_id_name(name)
    tier, rank = get_tier_rank(id)

    lol_key = 'sp4ceman' #current_user.lol_verification_key

    if check_verification_code(id, lol_key)
      if User.exists?(lol_name: real_name)
        #this shit alrdy exist
        duplicate_user = User.find_by(lol_name: real_name)
        duplicate_user.lol_name = nil
        duplicate_user.lol_tier = nil
        duplicate_user.lol_rank = nil
        duplicate_user.save
      end

      current_user.lol_name = real_name
      current_user.lol_tier = tier
      current_user.lol_rank = rank

      if current_user.save
        flash[:notice] = "Conta '#{real_name}' vinculada com sucesso!"
      else
        flash[:alert] = "Um erro inesperado aconteceu! D:"
      end
      redirect_back fallback_location: '/'
    else
      flash[:alert] = 'O codigo de verificacao nao confere...'
      redirect_back fallback_location: '/'
    end
  end

  def unverify
    current_user.lol_name = nil
    current_user.lol_tier = nil
    current_user.lol_rank = nil

    if current_user.save
      flash[:notice] = "Seu nome de invocador foi desvinculado com sucesso!"
      redirect_back fallback_location: '/'
    else
      flash[:alert] = "Oops... Algo deu errado..."
      redirect_back fallback_location: '/'
    end
  end
end
