class Admin::UserFormComponent < ViewComponent::Base
  attr_reader :user

  def initialize(user:)
    @user = user
    super()
  end

  def render?
    !user.role_superadmin?
  end

  def role_selection
    I18n.t('activerecord.attributes.user.roles').slice(:admin, :caretaker).map(&:reverse)
  end
end
