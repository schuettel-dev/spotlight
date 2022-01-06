class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  encrypts :email, deterministic: true
  encrypts :phone, deterministic: true

  has_many :light_requests, dependent: :destroy

  before_validation :sanitize_mobile

  validates :nickname, presence: true
  validates :nickname, uniqueness: true
  validate :verified_if_admin
  validate :not_updating_superadmin

  after_create :broadcast_admin_user_list
  after_update :broadcast_admin_user_info
  after_destroy :broadcast_admin_user_list

  enum role: { user: 'user', admin: 'admin', caretaker: 'caretaker', superadmin: 'superadmin' }, _prefix: true
  enum status: { unverified: 'unverified', verified: 'verified', blocked: 'blocked' }

  scope :ordered_by_nickname, -> { order(Arel.sql('lower(nickname) ASC')) }
  scope :with_light_requests, -> { includes(:light_requests).references(:light_requests) }

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

  def sanitize_mobile
    return if mobile.blank?

    self.mobile = mobile.gsub(/[^[0-9+]]*/, '')
                        .gsub(/^(00|\+)/, '')
                        .prepend('00')
  end

  def broadcast_admin_user_list
    broadcast_replace_to(
      'admin_user_list',
      target: 'admin_user_list',
      html: ApplicationController.render(
        Admin::UserListComponent.new(users: User.with_light_requests.ordered_by_nickname), layout: false
      )
    )
  end

  def broadcast_admin_user_info
    component = Admin::UserInfoComponent.new(user: self)
    broadcast_replace_to(
      'admin_user_list',
      target: component.to_dom_id,
      html: ApplicationController.render(component, layout: false)
    )
  end
end
