class Admin::WeekdayTemplateListComponent < ViewComponent::Base
  attr_reader :weekday_templates

  def initialize(weekday_templates:)
    @weekday_templates = weekday_templates
    super()
  end
end
