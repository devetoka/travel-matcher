# frozen_string_literal: true

module Filters
  class UserFilter < PostBaseFilter
    def apply(scope)
      return scope unless @params[:user].present?
      scope.where(user: @params[:user])
    end
  end
end
