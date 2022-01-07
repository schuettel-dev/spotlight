class Admin::WeekdayTemplateListItemComponent < ViewComponent::Base
  include Turbo::FramesHelper

  attr_reader :weekday_template

  delegate :display_weekday, :display_time, to: :weekday_template

  with_collection_parameter :weekday_template

  def initialize(weekday_template:)
    @weekday_template = weekday_template.decorate
    super()
  end

  def to_dom_id
    ActionView::RecordIdentifier.dom_id(weekday_template)
  end

  def form_component
    @form_component ||= Admin::WeekdayTemplateFormComponent.new(weekday_template: weekday_template)
  end

  def render_form?
    form_component.render?
  end

  def css_classes
    'text-gray-500' unless weekday_template.active?
  end
end
