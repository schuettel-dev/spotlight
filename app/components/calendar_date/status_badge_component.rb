class CalendarDate::StatusBadgeComponent < ViewComponent::Base
  CALENDAR_DATE_STATUSES = {
    date_in_future:               { css: 'bg-gray-300 text-gray-900'    , icon: :clock },
    awaiting_light_requests:      { css: 'bg-sky-300 text-gray-900'     , icon: :collection },
    requesting_light:             { css: 'bg-gray-500 text-gray-900'    , icon: :'status-online' },
    light_requested:              { css: 'bg-indigo-300 text-indigo-900', icon: :'phone-outgoing' },
    not_active_today:             { css: 'bg-purple-700 text-purple-300', icon: :moon },
    not_requested_until_deadline: { css: 'bg-purple-700 text-purple-300', icon: :moon },
    light_dismissed:              { css: 'bg-purple-700 text-purple-300', icon: :moon },
    light_confirmed:              { css: 'bg-green-400 text-gray-900'   , icon: :'light-bulb' }
  }.freeze

  attr_reader :status, :additional_classes

  def initialize(status:, additional_classes: 'w-24 h-24 p-6')
    @status = status
    @additional_classes = additional_classes
  end

  def color_classes
    CALENDAR_DATE_STATUSES.dig(status, :css)
  end

  def css_classes
    "#{color_classes} #{additional_classes}"
  end

  private

  def find_icon_key
    CALENDAR_DATE_STATUSES.dig(status, :icon)
  end
end
