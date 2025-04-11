# frozen_string_literal: true

module RequestFilters
  class MilestoneFilter < RequestBaseFilter
    def apply(scope)
      return scope unless @params[:milestone].present?
      scope.where(milestone: @params[:milestone])
    end
  end
end