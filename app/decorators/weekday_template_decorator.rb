class WeekdayTemplateDecorator < SimpleDelegator
  def display_weekday
    I18n.t('date.day_names')[weekday]
  end

  def display_request_window_ends_at
    I18n.l(request_window_ends_at, format: :day_time_only)
  end
end
