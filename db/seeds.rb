%w[00:00 15:00 15:00 15:00 15:00 15:00 00:00].each_with_index do |time, weekday|
  request_deadline = RequestDeadline.find_or_initialize_by(weekday: weekday)
  request_deadline.time = time
  request_deadline.active = (time != '00:00')
  request_deadline.save!
end
