class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:show]

  def index
    @posts = PostFilterService.new(params).call.page(params[:page])
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
      redirect_to posts_user_path(username: current_user.username), notice: "Post deleted successfully!"
    else
      redirect_to root_path, alert: "You can only delete your own posts"
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end


  def check_owner
    @requests = nil
    if @post.user == current_user
      @requests = RequestFilterService.new(request_params.merge(username: @post.user.username)).call(@post.requests)
                                      .page(params[:page])
    else
      puts "here " + Request.where(post: @post, requester: current_user).first.presence.inspect
      @request = Request.where(post: @post, requester: current_user).first.presence || Request.new
    end
  end

  def post_params
    params.require(:post).permit(:post_type, :origin, :destination, :date_range, :start_date, :end_date, :description, images: [])
  end

  def request_params
    params.permit(:id, :status, :direction, :milestone, :username)
  end
end