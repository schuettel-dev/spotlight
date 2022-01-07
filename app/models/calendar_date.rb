class CalendarDate < ApplicationRecord
  include CalendarDateStatus
  include Decorator

  after_initialize :calculate_deadline_at, if: :new_record?

  validates :date, presence: true
  validates :date, uniqueness: true

  has_many :light_requests, dependent: :destroy

  scope :with_light_requests, -> { includes(:light_requests).references(:light_requests) }
  scope :before_today_in_zurich, -> { before_date(CalendarService.today_in_zurich) }
  scope :before_date, ->(date) { where('date < :date', date: date) }
  scope :ordered_antichronologically, -> { order(date: :desc) }

  def self.for_today
    find_or_create_by(date: CalendarService.today_in_zurich)
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

  def reset_caretaker_decision!
    update(caretaker_confirmed_light_at: nil, caretaker_dismissed_light_at: nil)
  end

  private

  def calculate_deadline_at
    self.deadline_at = request_window.time_window_end
  end
end
