class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: [:accept, :reject]
  before_action :ensure_post_owner, only: [:accept, :reject]

  def create
    @request = Request.new(request_params.merge(requester: current_user))

    if @request.save
      message = @request.accepted? ? 'Post accepted' : 'Request sent'
      redirect_back fallback_location: post_path(@request.post), notice: "#{message} successfully!"
    else
      redirect_back fallback_location: post_path(@request.post), alert: "Failed to send request: #{@request.errors.full_messages.join(', ')}"
    end
  end

  def accept
    if @request.update(status: "accepted")
      redirect_back  fallback_location: post_path(@request.post), notice: "Request accepted! Contact info is now available below"
    else
      redirect_back  fallback_location: post_path(@request.post), alert: "Failed to accept request."
    end
  end

  def reject
    if @request.update(status: "rejected")
      redirect_back  fallback_location: post_path(@request.post), notice: "Request rejected."
    else
      redirect_back  fallback_location: post_path(@request.post), alert: "Failed to reject request."
    end
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def ensure_post_owner
    redirect_to posts_user_path(current_user.username), alert: "Only the post owner can accept or reject a request" unless @request.post.user == current_user
  end

  def request_params
    params.require(:request).permit(:post_id, :description, :status, images: [])
  end
end
