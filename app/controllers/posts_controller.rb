class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = []
  end
end
