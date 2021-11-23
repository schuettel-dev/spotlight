class LightRequest < ApplicationRecord
  before_commit :update_light_requests_counts

  belongs_to :calendar_date
  belongs_to :user

  private

  def update_light_requests_counts
    LightRequestsCountsUpdater.new(self).call
  end
end
