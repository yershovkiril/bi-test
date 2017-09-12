require_relative '../services/raw_sql.rb'

class SalesController < ApplicationController

  def by_dates
    return bad_request unless check_format('date', params[:report_start])
    return bad_request unless check_format('date', params[:report_end])

    query_params = { report_start: params[:report_start], report_end: params[:report_end] }
    result = RawSQL.new('profit_by_date.sql').result(query_params)
    @profit = result.first['profit'] || 0
    render 'by_dates.json'
  end

  def by_month
    return bad_request unless check_format('int', params[:count_sales])

    count_sales = params[:count_sales] ||= 200
    result = RawSQL.new('profit_by_group.sql').result(count_sales: count_sales)
    @profit = result
    render 'by_month.json'
  end

  def period
  end

  def sales
  end

  private

  def bad_request
    render :json => {:status => :bad_request}
  end

  def check_format(type, value)
    if type.eql? 'date'
      DateTime.parse value rescue return false
    else
      Integer(value) rescue return false
    end
  end
end
