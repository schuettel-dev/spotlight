class StatusSectionComponent < ViewComponent::Base
  attr_reader :calendar_date

  def initialize(calendar_date:)
    @calendar_date = calendar_date
  end
end
