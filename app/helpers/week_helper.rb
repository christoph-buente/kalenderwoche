module WeekHelper
  require 'icalendar'
  require 'digest/sha1'
  
  def link_to_previous_week(week, title)
    path = root_path if (week - 1 == current_week)
    path ||= week_path(week-1) if week > 1
    if path
      link_to title, path 
    else
      title
    end
  end
  
  def link_to_next_week(week, title)
    path = root_path if (week +1 == current_week)
    path ||= week_path(week+1) if week < end_of_last_week(Date.today.year).cweek
    if path
      link_to title, path 
    else
      title
    end
  end
  
  def link_to_this_week(title)
    link_to title, root_path
  end
  
  def current_week
    Date.today.cweek
  end
  
  def current_year
    Date.today.year
  end
  
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
        sunday = (monday.end_of_week) + 1
        cal.add_event(event_for_week(monday,sunday,count))
        monday = sunday
        count += 1
      end
    end
    cal.to_ical
  end
  
  def event_for_week(monday, sunday, count)
    event              = Icalendar::Event.new
    event.start        = monday
    event.end          = sunday
    event.summary      = "KW #{monday.cweek}"
    event.klass        = "PUBLIC"
    event.sequence     = count
    event.uid          = Digest::SHA1.hexdigest(monday.to_s + sunday.to_s)
    event
  end
    
  def last_week
    end_of_last_week(Date.today.year).cweek
  end
  
  def start_of_first_week(year)
    fourth_of_january = Date.parse("04.Jan.#{year}")
    fourth_of_january.beginning_of_week
  end
  
  def end_of_last_week(year)
    start_of_first_week(year+1) - 1.day
  end
end