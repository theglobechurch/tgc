Time::DATE_FORMATS[:month_and_year] = "%B %Y"
Time::DATE_FORMATS[:short_ordinal] = lambda do |time|
  time.strftime("%A #{time.day.ordinalize} %B")
end
Time::DATE_FORMATS[:just_time] = " %l:%M%P"
