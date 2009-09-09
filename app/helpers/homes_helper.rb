module HomesHelper
  require 'icalendar'
  
  def calendar(years)
    cal = Icalendar::Calendar.new
    cal.custom_property("PRODID","//christophbuente.de - Kalenderwochen//NONSGML//DE")
    cal.custom_property("X-WR-CALNAME", "Kalenderwochen")
    cal.custom_property("X-WR-CALDESC", "Kalenderwochen beginnend mit Montag")
    
    years.each_with_index do |year,i|
      first_week = start_of_first_week(year)
      52.times do |week|
        cal.add_event(event_for_week(year,week,i))
      end
    end
    cal.to_ical
  end
  
  def event_for_week(year, week, index)
    event              = Icalendar::Event.new
    event.start        = start_of_week(year, week)
    event.end          = end_of_week(year, week)
    event.summary      = "KW #{week+1}"
    event.klass        = "PUBLIC"
    event.sequence     = (index * 52) + week
    event.uid          = "KW #{index}"
    event
  end
  
  def start_of_week(year, week)
    start_of_first_week(year) + (week * 7).days
  end
  
  def end_of_week(year, week)
    start_of_week(year, week) +  7.days
  end
  
  def start_of_first_week(year)
    first_of_january = Date.parse("01.01.#{year}")
    first_of_january.beginning_of_week
  end
end