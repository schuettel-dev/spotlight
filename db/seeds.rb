%w[00:00 15:00 15:00 15:00 15:00 15:00 00:00].each_with_index do |request_window_ends_at, weekday|
  weekday_template = WeekdayTemplate.find_or_initialize_by(weekday: weekday)
  weekday_template.request_window_starts_at = '00:00'
  weekday_template.request_window_ends_at = request_window_ends_at
  weekday_template.active = (request_window_ends_at != '00:00')
  weekday_template.save!
end
