class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: [:accept, :show, :reject]
  before_action :ensure_post_owner, only: [:accept, :reject]
  before_action :ensure_can_view_request, only: [:show]

  def create
    @request = Request.new(request_params.merge(requester: current_user))

    if @request.save
      message = @request.accepted? ? 'Post accepted' : 'Request sent'
      redirect_back fallback_location: post_path(@request.post), notice: "#{message} successfully!"
    else
      redirect_back fallback_location: post_path(@request.post), alert: "Failed to send request: #{@request.errors.full_messages.join(', ')}"
    end
  end

  def show
    @other_party = @request.requester == current_user ? @request.post.user : @request.requester
  end

  def accept
    if @request.update(status: "accepted")
      redirect_to requests_user_path(current_user.username), notice: "Request accepted! Contact info is now available below"
    else
      redirect_to  requests_user_path(current_user.username), alert: @request.errors.full_messages.join(', ')
    end
  end

  def reject
    if @request.update(status: "rejected")
      redirect_to request_path(@request), notice: "Request rejected!"
    else
      puts @request.errors.full_messages.join(', ') + 'here'
      redirect_to request_path(@request), alert: @request.errors.full_messages.join(', ')
    end
  end

  private

  def ensure_can_view_request
    redirect_to root_path unless
      current_user.present? || (current_user == @request.post.user || current_user == @request.requester)
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def ensure_post_owner
    redirect_to requests_user_path(current_user.username), alert: "Only the post owner can accept or reject a request" unless @request.post.user == current_user
  end

  def request_params
    params.require(:request).permit(:post_id, :description, :status, images: [])
  end
end
