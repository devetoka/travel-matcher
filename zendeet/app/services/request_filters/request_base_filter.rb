# frozen_string_literal: true

module RequestFilters
  class RequestBaseFilter
    def initialize(params)
      @params = params
    end

    def self.new(*args)
      raise NotImplementedError, "#{self} is an abstract class and cannot be instantiated" if self == RequestBaseFilter
      # Here, we call super so that the implementing classes can be instantiated
      super
    end

    def apply(scope)
      raise NotImplementedError, "Subclasses must implement the `apply` method"
    end
  end
end
