class DeadlinesSectionComponent < ViewComponent::Base
  def weekday_template_classes(weekday_template)
    return 'request-deadlines--weekday-inactive' unless weekday_template.active?

    return 'request-deadlines--weekday-current' if CalendarService.today_in_zurich.wday == weekday_template.weekday

    'request-deadlines--weekday-active'
  end
end
