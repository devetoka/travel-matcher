# frozen_string_literal: true

module Filters
  class SearchFilter < PostBaseFilter
    def apply(scope)
      return scope unless @params[:search].present?
      scope.where(
        "posts.origin ILIKE :search OR posts.destination ILIKE :search OR posts.description ILIKE :search",
        search: "%#{@params[:search]}%"
      )
    end
  end
end
