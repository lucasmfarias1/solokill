class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def show
    @post = Post.find(params[:id])
    @new_post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    @post.parent_id = nil unless @post.parent

    respond_to do |format|
      if @post.save
        if @post.parent
          format.html { redirect_to post_path(@post.parent), notice: 'Postado!' }
          format.js
        else
          format.html { redirect_to '/', notice: 'Postado!' }
          format.js
        end
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
    params.require(:post).permit(:content, :parent_id)
  end
end
