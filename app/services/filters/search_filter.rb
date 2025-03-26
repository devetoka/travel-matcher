# frozen_string_literal: true

module Filters
  class SearchFilter < PostBaseFilter
    def apply(scope)
      return scope unless @params[:search].present?
      scope.where(
        "origin ILIKE :search OR destination ILIKE :search OR description ILIKE :search",
        search: "%#{@params[:search]}%"
      )
    end
  end
end
