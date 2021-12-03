class DeadlinesSectionComponent < ViewComponent::Base
  def request_deadline_classes(request_deadline)
    return 'text-gray-500' unless request_deadline.active?

    return 'text-sky-300' if CalendarService.today_in_time_zone.wday == request_deadline.weekday

    'text-gray-300'
  end
end
