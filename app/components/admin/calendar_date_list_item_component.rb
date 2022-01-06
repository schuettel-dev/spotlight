class Admin::CalendarDateListItemComponent < ViewComponent::Base
  attr_reader :calendar_date

  with_collection_parameter :calendar_date

  def initialize(calendar_date:)
    super()
    @calendar_date = calendar_date.decorate
  end
end
