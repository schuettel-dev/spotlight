class CalendarDate::StatusBadgeComponent < ViewComponent::Base
  attr_reader :status, :additional_classes

  def initialize(status:, additional_classes: 'w-24 h-24 p-6')
    super()
    @status = status.to_sym
    @additional_classes = additional_classes
  end

  def background_class
    self.class.settings.dig(status, :css, :background)
  end

  def text_class
    self.class.settings.dig(status, :css, :'text-secondary')
  end

  def color_classes
    [background_class, text_class].join(' ')
  end

  def css_classes
    "#{color_classes} #{additional_classes}"
  end

  def find_icon_key
    self.class.settings.dig(status, :icon)
  end

  def self.settings
    CalendarDateDecorator.statuses_settings
  end
end
