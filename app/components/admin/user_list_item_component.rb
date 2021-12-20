class Admin::UserListItemComponent < ViewComponent::Base
  attr_reader :user

  delegate :nickname, :email, to: :user

  with_collection_parameter :user

  def initialize(user:)
    @user = user
    super()
  end

  def role_badge
    render User::RoleBadgeComponent.new(user_role: @user.role)
  end
end
