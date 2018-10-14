class PostsController < ApplicationController
  before_action :authenticate_user!

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

        format.html { redirect_to '/', notice: 'Postado!' }
        format.js
      else
        format.html { redirect_to '/', alert: 'Failed.' }
        format.js
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])

    return false unless @post.user == current_user

    @post.destroy

    redirect_to '/', alert: 'Post deletado.'
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
