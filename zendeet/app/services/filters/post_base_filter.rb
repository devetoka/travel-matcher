# frozen_string_literal: true

module Filters
  class PostBaseFilter
    def initialize(params)
      @params = params
    end

    def self.new(*args)
      raise NotImplementedError, "#{self} is an abstract class and cannot be instantiated" if self == PostBaseFilter
      # Here, we call super so that the implementing classes can be instantiated
      super
    end

    def apply(scope)
      raise NotImplementedError, "Subclasses must implement the `apply` method"
    end
  end
end
class PostBaseFilter
end
