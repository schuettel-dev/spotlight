class DateSectionComponent < ViewComponent::Base
  attr_reader :calendar_date

  delegate :display_date, :display_sun_sets_at, to: :calendar_date

  def initialize(calendar_date:)
    @calendar_date = calendar_date.decorate
  end
end
