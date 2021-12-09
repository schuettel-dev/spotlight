class CalendarDate < ApplicationRecord
  include CalendarDateStatus

  validates :date, presence: true
  validates :date, uniqueness: true

  has_many :light_requests, dependent: :destroy

  scope :with_light_requests, -> { left_outer_joins(:light_requests).includes(:light_requests) }

  def self.for_today
    find_or_initialize_by(date: CalendarService.today_in_time_zone)
  end

  def request_window
    @request_window ||= RequestWindowService.new(self)
  end

  def caretaker_informed?
    caretaker_informed_at.present?
  end

  def caretaker_informed!
    update(caretaker_informed_at: Time.zone.now)
  end

  def caretaker_confirmed_light?
    caretaker_confirmed_light_at.present?
  end

  def caretaker_confirmed_light!
    update(caretaker_confirmed_light_at: Time.zone.now, caretaker_dismissed_light_at: nil)
  end

  def caretaker_dismissed_light?
    caretaker_dismissed_light_at.present?
  end

  def caretaker_dismissed_light!
    update(caretaker_confirmed_light_at: nil, caretaker_dismissed_light_at: Time.zone.now)
  end
end
