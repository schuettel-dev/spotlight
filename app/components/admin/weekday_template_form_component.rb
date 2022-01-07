class Admin::WeekdayTemplateFormComponent < ViewComponent::Base
  attr_reader :weekday_template

  def initialize(weekday_template:)
    @weekday_template = weekday_template
    super()
  end

  def render?
    weekday_template.active?
  end

  def selected_request_window_ends_at
    weekday_template.decorate.display_request_window_ends_at
  end

  def request_window_ends_at_select_options
    @request_window_ends_at_select_options ||= find_request_window_ends_at_select_options
  end

  private

  def find_request_window_ends_at_select_options(args = {})
    current_time = args[:from] || DateTime.new(2000, 1, 1, 10, 0, 0, +0)
    end_time = args[:to] || DateTime.new(2000, 1, 1, 20, 0, 0, +0)

    time_steps = [current_time]

    while current_time < end_time
      current_time += 15.minutes
      time_steps << current_time
    end

    time_steps.map { |time_step| I18n.l(time_step, format: :day_time_only) }
  end
end
