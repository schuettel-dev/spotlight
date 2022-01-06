class Admin::CalendarDateListItemComponent < ViewComponent::Base
  attr_reader :calendar_date

  with_collection_parameter :calendar_date

  def initialize(calendar_date:)
    @calendar_date = calendar_date.decorate
  end

  # def render_form?
  #   CalendarService.all_day_in_time_zone(calendar_date.date).cover?(CalendarService.now_in_time_zone)
  # end
end
