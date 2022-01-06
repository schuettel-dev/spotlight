class HeaderComponent < ViewComponent::Base
  attr_reader :current_user

  def initialize(current_user:)
    @current_user = current_user
  end

  def signed_in?
    current_user.present?
  end

  def admin?
    current_user&.admin?
  end
end
