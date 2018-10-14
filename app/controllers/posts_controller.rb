class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        Pusher.trigger('posts-channel','new-post', {
          user: @post.user.name
        })

        format.html { redirect_to '/', notice: 'Posted!' }
        format.js
      else
        format.html { redirect_to '/', alert: 'Failed!' }
        format.js
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
