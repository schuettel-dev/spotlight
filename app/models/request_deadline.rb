class RequestDeadline < ApplicationRecord
  validates :time, presence: true

  after_save :broadcast_request_deadline

  scope :ordered, -> { order(Arel.sql('(weekday + 6) % 7')) }

  def self.for_date(date)
    find_by(weekday: date.wday)
  end

  def self.for_today
    for_date(CalendarService.today_in_time_zone)
  end

  def set_time(hh_mm_string) # rubocop:disable Naming/AccessorMethodName
    hour, minute = hh_mm_string.split(':').map(&:to_i)
    self.time = time.change(hour: hour, min: minute)
  end

  def update_time(hh_mm_string)
    set_time(hh_mm_string)
    save
  end

  def toggle_active!
    update!(active: !active)
  end

  private

  def broadcast_request_deadline
    component = Admin::RequestDeadlineFormComponent.new(request_deadline: self)
    broadcast_replace_to(
      'request_deadlines',
      target: component.to_dom_id,
      html: ApplicationController.render(component, layout: false)
    )
  end
end
