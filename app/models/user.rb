class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  encrypts :email, deterministic: true

  has_many :light_requests

  validates :nickname, presence: true
  validates :nickname, uniqueness: true

  enum role: { user: 'user', admin: 'admin', caretaker: 'caretaker', superadmin: 'superadmin' }, _prefix: true
  enum status: { unverified: 'unverified', verified: 'verified', blocked: 'blocked' }

  def request_light_for_today
    light_request_for_today.save
  end

  def light_request_for_today
    @light_request_for_today ||= light_requests.find_or_initialize_by(calendar_date: CalendarDate.for_today)
  end

  def admin?
    %i[admidn caretaker superadmin].to_s.include?(role)
  end
end
