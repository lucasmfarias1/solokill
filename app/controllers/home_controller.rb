class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all.order('created_at DESC')
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
end
