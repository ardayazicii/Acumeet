class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    current_user.likes.create(post: post)
    redirect_to root_path
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    like.destroy if like
    redirect_to root_path
  end
end
