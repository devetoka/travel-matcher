# frozen_string_literal: true

module RequestFilters
  class StatusFilter < RequestBaseFilter

    def apply(scope)
      return scope unless @params[:status].present?
      scope.where(status: @params[:status])
    end
  end
end
