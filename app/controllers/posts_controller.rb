class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page])
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to root_path, alert: "You can only edit your own posts" unless @post.user == current_user
  end

  def update
    if @post.user == current_user && @post.update(post_params)
      redirect_to @post, notice: "Post updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: "Post deleted successfully!"
    else
      redirect_to root_path, alert: "You can only delete your own posts"
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
  ''
  def post_params
    params.require(:post).permit(:post_type, :origin, :destination, :date_range, :start_date, :end_date, :description)
  end
end