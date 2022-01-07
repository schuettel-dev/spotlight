class WeekdayTemplate < ApplicationRecord
  include Decorator

  validates :weekday, :request_window_starts_at, :request_window_ends_at, presence: true

  after_save :broadcast_weekday_template

  scope :ordered, -> { order(Arel.sql('(weekday + 6) % 7')) }

  def self.for_date(date)
    find_by(weekday: date.wday)
  end

  def self.for_today
    for_date(CalendarService.today_in_zurich)
  end

  def set_request_window_ends_at(hh_mm_string) # rubocop:disable Naming/AccessorMethodName
    hour, minute = hh_mm_string.split(':').map(&:to_i)
    self.request_window_ends_at = request_window_ends_at.change(hour: hour, min: minute)
  end

  def update_request_window_ends_at(hh_mm_string)
    set_request_window_ends_at(hh_mm_string)
    save
  end

  def toggle_active!
    update!(active: !active)
  end

  private

  def broadcast_weekday_template
    component = Admin::WeekdayTemplateListItemComponent.new(weekday_template: self)
    broadcast_replace_to(
      'admin_weekday_templates',
      target: component.to_dom_id,
      html: ApplicationController.render(component, layout: false)
    )
  end
end
