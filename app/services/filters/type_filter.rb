# frozen_string_literal: true

module Filters
  class TypeFilter < PostBaseFilter
    def apply(scope)
      puts "here"
      return scope unless @params[:type].present?
      scope.where(post_type: @params[:type])
    end
  end
end
