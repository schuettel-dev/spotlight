class Admin::RequestDeadlineListItemComponent < ViewComponent::Base
  include Turbo::FramesHelper

  attr_reader :request_deadline

  delegate :display_weekday, :display_time, to: :request_deadline

  with_collection_parameter :request_deadline

  def initialize(request_deadline:)
    @request_deadline = request_deadline.decorate
  end

  def to_dom_id
    ActionView::RecordIdentifier.dom_id(request_deadline)
  end

  def render_form?
    request_deadline.active?
  end
end
