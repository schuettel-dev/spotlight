class Admin::UserInfoComponent < ViewComponent::Base
  attr_reader :user

  delegate :nickname, :email, to: :user

  def initialize(user:)
    @user = user
    super()
  end

  def role_badge
    render User::RoleBadgeComponent.new(user_role: @user.role)
  end

  def dom_id
    "#{ActionView::RecordIdentifier.dom_id(user)}_info"
  end
end
