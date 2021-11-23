class RequestDeadline < ApplicationRecord
  validates :time, presence: true

  scope :ordered, -> { order(weekday: :asc) }
end
