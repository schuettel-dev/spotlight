class Admin::UserFormComponent < ViewComponent::Base
  include Turbo::FramesHelper

  attr_reader :user

  def initialize(user:)
    @user = user
    super()
  end

  def render?
    !user.role_superadmin?
  end

  def render_form?
    user.verified? && !user.role_superadmin?
  end

  def to_dom_id
    "#{ActionView::RecordIdentifier.dom_id(user)}_form"
  end

  def role_selection
    I18n.t('activerecord.attributes.user.roles').slice(:user, :admin, :caretaker).map(&:reverse)
  end
end
