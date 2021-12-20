class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  encrypts :email, deterministic: true

  has_many :light_requests, dependent: :destroy

  validates :nickname, presence: true
  validates :nickname, uniqueness: true
  validate :verified_if_admin
  validate :not_updating_superadmin

  after_create :broadcast_user_list

  enum role: { user: 'user', admin: 'admin', caretaker: 'caretaker', superadmin: 'superadmin' }, _prefix: true
  enum status: { unverified: 'unverified', verified: 'verified', blocked: 'blocked' }

  scope :ordered_by_nickname, -> { order(Arel.sql('lower(nickname) ASC')) }
  scope :with_light_requests, -> { references(:light_requests).references(:light_requests) }

  def request_light_for_today
    light_request_for_today.save
  end

  def light_request_for_today
    @light_request_for_today ||= light_requests.find_or_initialize_by(calendar_date: CalendarDate.for_today)
  end

  def admin?
    %i[admin caretaker superadmin].to_s.include?(role.to_s)
  end

  private

  def verified_if_admin
    errors.add(:status, :admin_need_to_be_verified) if admin? && !verified?
  end

  def not_updating_superadmin
    return unless role_changed?
    return unless role_superadmin? || role_was == 'superadmin'

    errors.add(:role, :updating_from_or_to_superadmin_is_not_allowed)
  end

  def broadcast_user_list
    broadcast_replace_to(
      'user_list',
      target: 'user_list',
      html: ApplicationController.render(
        Admin::UserListComponent.new(users: User.with_light_requests.ordered_by_nickname), layout: false
      )
    )
  end
end
