class ProfileComponent < ViewComponent::Base
  attr_reader :current_user

  def initialize(current_user:)
    @current_user = current_user
  end

  def available_locales_options
    I18n.t('available_locales').map(&:reverse).sort_by(&:first)
  end
end
