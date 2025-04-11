# frozen_string_literal: true

module RequestFilters
  class DirectionFilter < RequestBaseFilter
    def initialize(params)
      super(params)
      @user = User.find_by!(username: @params[:username])
    end

    def apply(scope)
      case @params[:direction]
      when "sent"
        scope.where(requester: @user)
      when "received"
        scope.where(posts: { user_id: @user.id })
      else
        scope
      end
    end
  end
end