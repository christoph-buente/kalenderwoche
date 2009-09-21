class WeekController < ApplicationController
  include WeekHelper
  # caches_action :index

  before_filter :set_date_and_week
  
  def index
    respond_to do |wants|
      wants.html{}
      wants.ics{
        start_date = 1.years.ago
        end_date = 1.years.from_now
        years = (start_date.year..end_date.year).to_a
        headers['Content-Type'] = "text/calendar; charset=UTF-8"
        render :text => calendar(years), :layout => false        
      }
    end
  end
  
  def show
    render :action => :index
  end
  
  protected
  
  def set_date_and_week
    @week = params[:id] if params[:id]
    redirect_to root_path if @week == current_week.to_s
    @week = @week.to_i if @week
    @week =  current_week unless @week
    @start_date = start_of_first_week(Date.today.year) + @week.to_i.weeks - 1.week
    @end_date = @start_date.end_of_week
  end
  
end