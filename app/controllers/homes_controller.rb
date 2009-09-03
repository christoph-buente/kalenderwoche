class HomesController < ApplicationController
  include HomesHelper
  caches_action :index
  
  def index
    start_date = 1.year.ago
    end_date = 2.years.from_now
    years = (start_date.year..end_date.year)
    respond_to do |format|
      format.ics do
        headers['Content-Type'] = "text/plain; charset=UTF-8"
        # headers['Content-Type'] = "text/calendar; charset=UTF-8"
        render :text => calendar(years), :layout => false
      end
    end
  end
end