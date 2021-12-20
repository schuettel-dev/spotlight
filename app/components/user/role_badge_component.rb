class User::RoleBadgeComponent < ViewComponent::Base
  attr_reader :user_role

  USER_ROLE_CSS_CLASSES = {
    admin: 'text-amber-300',
    caretaker: 'text-fuchsia-300',
    superadmin: 'text-lime-300'
  }.freeze

  def initialize(user_role:)
    @user_role = user_role
    super()
  end

  def render?
    User.roles.without(:user).include?(user_role)
  end

  def css_classes
    "#{USER_ROLE_CSS_CLASSES[user_role.to_sym]} text-xs"
  end
end
