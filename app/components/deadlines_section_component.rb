class DeadlinesSectionComponent < ViewComponent::Base
  def request_deadline_classes(request_deadline)
    return 'request-deadlines--weekday-inactive' unless request_deadline.active?

    return 'request-deadlines--weekday-current' if CalendarService.today_in_time_zone.wday == request_deadline.weekday

    'request-deadlines--weekday-active'
  end
end
