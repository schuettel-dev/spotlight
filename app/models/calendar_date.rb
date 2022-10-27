class CalendarDate < ApplicationRecord
  include CalendarDateStatus
  include Decorator

  after_initialize :initialize_active, if: :new_record?
  after_initialize :initialize_request_window, if: :new_record?
  after_initialize :initialize_sun_sets_at, if: :new_record?

  after_update :broadcast

  validates :date, :request_window_starts_at, :request_window_ends_at, presence: true
  validates :date, uniqueness: true
  validates :request_window_ends_at, comparison: { greater_than_or_equal_to: :request_window_starts_at }
  validate :request_window_ends_at_within_date
  validate :sun_sets_at_within_date

  has_many :light_requests, dependent: :destroy

  scope :with_light_requests, -> { includes(:light_requests).references(:light_requests) }
  scope :before_today_in_zurich, -> { before_date(CalendarService.today_in_zurich) }
  scope :before_date, ->(date) { where('date < :date', date: date) }
  scope :ordered_antichronologically, -> { order(date: :desc) }

  def self.find_or_create_for_today
    find_or_create_by(date: CalendarService.today_in_zurich)
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

  def request_window_open_at?(time)
    request_window.cover?(time)
  end

  private

  def initialize_active
    self.active = WeekdayTemplate.for_date(date).active
  end

  def initialize_request_window
    request_window_service = RequestWindowService.new(self)
    self.request_window_starts_at = request_window_service.request_window_starts_at
    self.request_window_ends_at = request_window_service.request_window_ends_at
  end

  def initialize_sun_sets_at
    self.sun_sets_at = SchachenSunsets.on(date)
  end

  def request_window_ends_at_within_date
    return if all_day.cover?(request_window_ends_at)

    errors.add(:request_window_ends_at, :cannot_be_outside_date)
  end

  def sun_sets_at_within_date
    return if all_day.cover?(sun_sets_at)

    errors.add(:sun_sets_at, :cannot_be_outside_date)
  end

  def all_day
    @all_day ||= CalendarService.all_day_in_zurich(date)
  end

  def request_window
    (request_window_starts_at..request_window_ends_at)
  end

  def broadcast
    CalendarDateBroadcaster.new(self).call
  end
end
