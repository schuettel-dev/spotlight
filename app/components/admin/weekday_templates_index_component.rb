class Admin::WeekdayTemplatesIndexComponent < ViewComponent::Base
  include Turbo::StreamsHelper

  attr_reader :weekday_templates

  def initialize(weekday_templates:)
    @weekday_templates = weekday_templates
    super()
  end
end
