class LightRequest < ApplicationRecord
  before_commit :update_light_requests_counts

  belongs_to :calendar_date
  belongs_to :user

  private

  def broadcast_light_requests
    broadcast_replace_to(
      'light_requests',
      target: 'light_requests',
      html: ApplicationController.render(LightRequestsComponent.new(calendar_date: self.calendar_date), layout: false)
    )
  end
end
