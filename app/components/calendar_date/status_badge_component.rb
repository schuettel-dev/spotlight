class CalendarDate::StatusBadgeComponent < ViewComponent::Base
  # CALENDAR_DATE_STATUSES = {
  #   date_in_future:               { css: { border: 'border-gray-300'  , background: 'bg-gray-300'  , text: 'text-gray-900' }  , icon: :clock },
  #   awaiting_light_requests:      { css: { border: 'border-sky-300'   , background: 'bg-sky-300'   , text: 'text-gray-900' }  , icon: :collection },
  #   requesting_light:             { css: { border: 'border-gray-500'  , background: 'bg-gray-500'  , text: 'text-gray-900' }  , icon: :'status-online' },
  #   light_requested:              { css: { border: 'border-indigo-300', background: 'bg-indigo-300', text: 'text-indigo-900' }, icon: :'phone-outgoing' },
  #   not_active_today:             { css: { border: 'border-purple-700', background: 'bg-purple-700', text: 'text-purple-300' }, icon: :moon },
  #   not_requested_until_deadline: { css: { border: 'border-purple-700', background: 'bg-purple-700', text: 'text-purple-300' }, icon: :moon },
  #   light_dismissed:              { css: { border: 'border-purple-700', background: 'bg-purple-700', text: 'text-purple-300' }, icon: :moon },
  #   light_confirmed:              { css: { border: 'border-green-400' , background: 'bg-green-400' , text: 'text-gray-900' }  , icon: :'light-bulb' }
  # }.freeze

  attr_reader :status, :additional_classes

  def initialize(status:, additional_classes: 'w-24 h-24 p-6')
    @status = status
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
