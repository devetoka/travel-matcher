class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :authorize_user, only: %i[change_password]


  def show
    unless @user
      flash[:alert] = "User not found."
      redirect_to root_path
    end
  end


  def change_password
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
