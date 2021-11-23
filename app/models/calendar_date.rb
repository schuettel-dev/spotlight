class CalendarDate < ApplicationRecord
  validates :date, presence: true
  validates :date, uniqueness: true

  has_many :light_requests

  enum status: { collecting_requests: 'collecting_requests', requested: 'requested',
                 confirmed: 'confirmed', dismissed: 'dismissed' }

  scope :with_light_requests, -> { left_outer_joins(:light_requests).includes(:light_requests) }

  def self.for_today
    find_or_initialize_by(date: CalendarService.today_in_time_zone)
  end

  def request_window_open?
    true
  end
end
