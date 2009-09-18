module HomesHelper
  require 'icalendar'
  require 'digest/sha1'
  
  def calendar(years)
    cal = Icalendar::Calendar.new
    cal.custom_property("PRODID","//christophbuente.de - Kalenderwochen//NONSGML//DE")
    cal.custom_property("X-WR-CALNAME", "Kalenderwochen")
    cal.custom_property("X-WR-CALDESC", "Kalenderwochen beginnend mit Montag")
    
    count = 0
    years.each do |year|
      monday = start_of_first_week(year)
      last_day = end_of_last_week(year)
      while monday < last_day do
        cal.add_event(event_for_week(monday,count))
        monday += 7
        count += 1
      end
    end
    cal.to_ical
  end
  
  def event_for_week(monday, count)
    event              = Icalendar::Event.new
    event.start        = monday
    event.end          = monday + 7
    event.summary      = "KW #{monday.cweek}"
    event.klass        = "PUBLIC"
    event.sequence     = count
    event.uid          = Digest::SHA1.hexdigest(monday.to_s)
    event
  end
    
  def start_of_first_week(year)
    fourth_of_january = Date.parse("04.Jan.#{year}")
    fourth_of_january.beginning_of_week
  end
  
  def end_of_last_week(year)
    Date.parse("04.Jan.#{year}").end_of_year
  end
end