class HomeController < ApplicationController
  before_action :authenticate_user!
  include ApplicationHelper
  def index
    @posts = Post.all.order('created_at DESC')

    if current_user.lol_verification_key
      @code = current_user.lol_verification_key
    else
      current_user.lol_verification_key = generate_key
      current_user.save
      @code = current_user.lol_verification_key
    end
  end

  def new_post
    post = Post.new
    post.user = current_user
    post.content = params[:post][:content]

    if post.save
      flash[:notice] = 'Posted!'
      redirect_back fallback_location: '/'
    else
      flash[:notice] = "The post " + post.errors["content"][0]
      redirect_back fallback_location: '/'
    end
  end

  def verify
    name = params[:summoner_name]
    id = get_summoner_id(name)
    tier = get_tier_rank(id)

    # just for tests, works btw
    flash[:notice] = "name = #{name} id = #{id} tier = #{tier}"

    redirect_back fallback_location: '/'
  end
end
