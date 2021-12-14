class RequestDeadlineFormComponent < ViewComponent::Base
  attr_reader :request_deadline

  with_collection_parameter :request_deadline

  def initialize(request_deadline:)
    @request_deadline = request_deadline
  end

  def css_classes
    request_deadline.active? ? 'admin-request-deadline--active' : 'admin-request-deadline--inactive'
  end

  def selected_time
    to_formatted_time(request_deadline.time)
  end

  def time_select_options
    @time_select_options ||= find_time_select_options
  end

  private

  def to_formatted_time(value)
    I18n.l(value, format: :day_time_only)
  end

  def find_time_select_options(args = {})
    current_time = args[:from] || DateTime.new(2000, 1, 1, 10, 0, 0, +0)
    end_time = args[:to] || DateTime.new(2000, 1, 1, 20, 0, 0, +0)

    time_steps = [current_time]

    while current_time < end_time
      current_time = current_time + 15.minutes
      time_steps << current_time
    end

    time_steps.map(&method(:to_formatted_time))
  end
end
