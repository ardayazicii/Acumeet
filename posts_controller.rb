class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.includes(:user, image_attachment: :blob).order(created_at: :desc)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, notice: "Post created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to root_path, notice: "Post deleted."
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image)
  end
end
