# frozen_string_literal: true

module Filters
  class DateFilter < PostBaseFilter
    def apply(scope)
      case @params[:date_filter]
      when "this_week"
        scope.where(start_date: Date.today.beginning_of_week..Date.today.end_of_week)
      when "this_month"
        scope.where(start_date: Date.today.beginning_of_month..Date.today.end_of_month)
      when "custom"
        if @params[:start_date].present? && @params[:end_date].present?
          scope.where(start_date: @params[:start_date]..@params[:end_date])
        else
          scope
        end
      else
        scope
      end
    end
  end
end
