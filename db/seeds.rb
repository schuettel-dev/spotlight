%w[00:00 15:00 15:00 15:00 15:00 15:00 00:00].each_with_index do |time, weekday|
  weekday_template = WeekdayTemplate.find_or_initialize_by(weekday: weekday)
  weekday_template.time = time
  weekday_template.active = (time != '00:00')
  weekday_template.save!
end
