class User::StatusBadgeComponent < ViewComponent::Base
  attr_reader :status

  USER_STATUS_CSS_CLASSES = {
    unverified: :NONE,
    verified: 'text-green-500',
    blocked: 'text-rose-400'
  }.freeze

  USER_STATUS_ICON = {
    unverified: :NONE,
    verified: :'badge-check',
    blocked: :ban
  }.freeze

  def initialize(status:)
    @status = status.to_sym
    super()
  end

  def render?
    status != :unverified
  end

  def css_classes
    USER_STATUS_CSS_CLASSES[status]
  end

  def icon
    render HeroiconComponent.new(find_user_status_icon_key) if find_user_status_icon_key != :NONE
  end

  private

  def find_user_status_icon_key
    USER_STATUS_ICON[status]
  end
end
