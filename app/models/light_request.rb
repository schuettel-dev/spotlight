class LightRequest < ApplicationRecord
  belongs_to :calendar_date
  belongs_to :user

  validate :request_window_open?
  before_destroy :request_window_open?

  private

  def broadcast_light_requests
    broadcast_replace_to(
      'light_requests',
      target: 'light_requests',
      html: ApplicationController.render(LightRequestsComponent.new(calendar_date: self.calendar_date), layout: false)
    )
  end

  private

  def request_window_open?
    return if calendar_date.request_window.open?

    errors.add(:request_window_closed) && throw(:abort)
  end
end
