class CalendarDate < ApplicationRecord
  include CalendarDateStatus
  include Decorator

  validates :date, presence: true
  validates :date, uniqueness: true

  has_many :light_requests, dependent: :destroy

  scope :with_light_requests, -> { includes(:light_requests).references(:light_requests) }
  scope :ordered_antichronologically, -> { order(date: :desc) }

  def self.for_today
    find_or_initialize_by(date: CalendarService.today_in_time_zone)
  end

  def request_window
    @request_window ||= RequestWindowService.new(self)
  end

  def sun_sets_at
    SchachenSunsets.on(date)
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
