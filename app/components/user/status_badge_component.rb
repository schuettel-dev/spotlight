class User::StatusBadgeComponent < ViewComponent::Base
  attr_reader :status

  USER_STATUSES = {
    verified: {
      css: 'text-green-500',
      icon: :'badge-check'
    },
    blocked: {
      css: 'text-rose-400',
      icon: :ban
    }
  }.freeze

  def initialize(status:)
    @status = status.to_sym
    super()
  end

  def render?
    USER_STATUSES.keys.include?(status)
  end

  def css_classes
    USER_STATUSES.dig(status, :css)
  end

  def icon
    render HeroiconComponent.new(find_user_status_icon_key)
  end

  private

  def find_user_status_icon_key
    USER_STATUSES.dig(status, :icon)
  end
end
