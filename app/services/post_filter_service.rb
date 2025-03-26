# frozen_string_literal: true

class PostFilterService
  def initialize(params)
    @params = params
  end

  def call(scope = Post.all.order(created_at: :desc))
    filters.reduce(scope) do |scope, filter|
      filter.new(@params).apply(scope)
    end
  end

  private
  def filters
    list_of_filters = Dir[Rails.root.join('app','''services', 'filters', '*.rb')].map do |path|
      class_name = File.basename(path, '.rb').camelize
      "Filters::#{class_name}".constantize
    end

    list_of_filters.select do |filter|
      filter < Filters::PostBaseFilter && filter != Filters::PostBaseFilter
    end
  end
end
