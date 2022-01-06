class CalendarDateDecorator < SimpleDelegator
  def self.statuses_settings
    Rails.application.config.settings.dig(:calendar_date, :statuses)
  end

  def statuses_settings
    self.class.statuses_settings
  end

  def display_date
    date.to_formatted_s(:long)
  end

  def display_sun_sets_at
    I18n.l(sun_sets_at.in_time_zone('Europe/Zurich'), format: :day_time_only)
  end

  def display_status
    CalendarDate.human_enum_name(:status, status)
  end

  def display_light_requests_with_count
    I18n.t('shared.models.light_request.with_count', count: light_requests.size)
  end
end
