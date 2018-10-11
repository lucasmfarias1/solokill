class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.where("user_id = ?", @user)
                 .order('created_at DESC')
                 .page(params[:page]).per(10)
  end
end
