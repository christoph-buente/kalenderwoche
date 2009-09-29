module WeekHelper
  require 'icalendar'
  require 'digest/sha1'
  
  def link_to_week(week, year=current_year)
    if year != current_year
      link_to week, year_week_path(year,week)
    else
      link_to week, week_path(week)
    end
  end
  
  def link_to_previous_week(week, year=current_year, title=I18n.t('week.show.previous_week'))
    if week >= 1
      link_to_previous_week_with_year(week,year,title)
    else
      last_year = (year - 1)
      link_to_previous_week_with_year(last_week(last_year), last_year, title)
    end
  end
  
  def link_to_previous_week_without_year(week, title=I18n.t('week.show.previous_week'))
      link_to title, week_path(week)
  end
  
  def link_to_previous_week_with_year(week, year=current_year, title=I18n.t('week.show.previous_week'))
    if year == current_year
      link_to_previous_week_without_year(week, title)
    else
      link_to title, year_week_path(year,week)  
    end
  end
  
  def link_to_next_week(week, year=current_year, title=I18n.t('week.show.next_week'))
    if week <= last_week(year)
      link_to_next_week_with_year(week,year,title)
    else
      next_year = (year + 1)
      link_to_next_week_with_year(1, next_year, title)
    end
  end  
  
  def link_to_next_week_without_year(week, title=I18n.t('week.show.previous_week'))
    link_to title, week_path(week)
  end
  
  def link_to_next_week_with_year(week, year=current_year, title=I18n.t('week.show.previous_week'))
    if year == current_year
      link_to_next_week_without_year(week, title)
    else
      link_to title, year_week_path(year,week)  
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
    cal.custom_property("PRODID","//christophbuente.de - #{I18n.t("week.index.calendar_weeks")}//NONSGML//DE")
    cal.custom_property("X-WR-CALNAME", I18n.t("week.index.calendar_weeks"))
    cal.custom_property("X-WR-CALDESC", I18n.t("week.index.calendar_weeks_beginning_on_monday"))
    
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
    event.summary      = "#{I18n.t('week.index.cw')} #{monday.cweek}"
    event.klass        = "PUBLIC"
    event.sequence     = count
    event.uid          = Digest::SHA1.hexdigest(monday.to_s + sunday.to_s)
    event
  end
    
  def last_week(year)
    end_of_last_week(year).cweek
  end
  
  def start_of_first_week(year)
    fourth_of_january = Date.parse("04.Jan.#{year}")
    fourth_of_january.beginning_of_week
  end
  
  def end_of_last_week(year)
    start_of_first_week(year+1) - 1.day
  end
end