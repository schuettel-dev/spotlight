class WeekdayTemplateDecorator < SimpleDelegator
  def display_weekday
    I18n.t('date.day_names')[weekday]
  end

  def display_time
    I18n.l(time, format: :day_time_only)
  end
end
