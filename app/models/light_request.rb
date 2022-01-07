class LightRequest < ApplicationRecord
  belongs_to :calendar_date
  belongs_to :user

  validate :request_window_open_now?
  before_destroy :request_window_open_now?

  private

  def broadcast_light_requests
    broadcast_replace_to(
      'light_requests',
      target: 'light_requests',
      html: ApplicationController.render(LightRequestsComponent.new(calendar_date: calendar_date), layout: false)
    )
  end

  def request_window_open_now?
    return if calendar_date.request_window_open_now?

    errors.add(:base, :request_window_closed) && throw(:abort)
  end
end
