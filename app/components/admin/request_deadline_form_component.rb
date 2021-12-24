class Admin::RequestDeadlineFormComponent < ViewComponent::Base
  attr_reader :request_deadline

  def initialize(request_deadline:)
    @request_deadline = request_deadline
    super()
  end

  def render?
    request_deadline.active?
  end

  def selected_time
    request_deadline.decorate.display_time
  end

  def time_select_options
    @time_select_options ||= find_time_select_options
  end

  private

  def find_time_select_options(args = {})
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
