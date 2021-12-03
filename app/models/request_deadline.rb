class RequestDeadline < ApplicationRecord
  validates :time, presence: true

  scope :ordered, -> { order(Arel.sql('(weekday + 6) % 7')) }

  def self.for_date(date)
    find_by(weekday: date.wday)
  end

  def self.for_today
    for_date(CalendarService.today_in_time_zone)
  end

  def update_time(hh_mm_string)
    hour, minute = hh_mm_string.split(':').map(&:to_i)
    self.time = time.change(hour: hour, min: minute)
    save
  end
end
