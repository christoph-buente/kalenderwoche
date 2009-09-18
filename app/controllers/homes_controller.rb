class HomesController < ApplicationController
  include HomesHelper
  # caches_action :index
  
  def index
    start_date = 1.years.ago
    end_date = 1.years.from_now
    years = (start_date.year..end_date.year).to_a
    headers['Content-Type'] = "text/calendar; charset=UTF-8"
    render :text => calendar(years), :layout => false
  end
end