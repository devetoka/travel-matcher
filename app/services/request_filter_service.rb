# frozen_string_literal: true

class RequestFilterService
  def initialize(params)
    @params = params
  end

  def call(scope = Request.all)
    filters.reduce(scope) do |current_scope, filter|
      filter.new(@params).apply(current_scope)
    end
  end

  private

  def filters
    list_of_filters = Dir[Rails.root.join('app', 'services', 'request_filters', '*.rb')].map do |path|
      class_name = File.basename(path, '.rb').camelize
      "RequestFilters::#{class_name}".constantize
    end

    list_of_filters.select do |filter|
      filter < RequestFilters::RequestBaseFilter && filter != RequestFilters::RequestBaseFilter
    end
  end
end