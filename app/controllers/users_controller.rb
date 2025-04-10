class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user
  before_action :authorize_user, except: [:show]


  def show
    unless @user
      flash[:alert] = "User not found."
      redirect_to root_path
    end

    @posts = @user.posts.order(created_at: :desc).limit(5) # Latest 5 posts
    @requests = @user.requests.order(created_at: :desc).limit(5) # Latest 5 requests
    @reviews = @user.received_reviews.order(created_at: :desc).page(params[:page])
    @average_rating = @user.received_reviews.average(:rating).to_f.round(1)
  end

  def edit
  end


  def change_password
  end

  def posts
    params[:user] = current_user
    @posts = PostFilterService.new(params).call.page(params[:page])
  end

  def requests
    @requests = RequestFilterService.new(
      params.merge(username: @user.username)
    ).call(
      @user.all_requests.order(created_at: :desc)
    ).page(params[:page])
  end

  private 

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def authorize_user
    unless @user == current_user
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
end
