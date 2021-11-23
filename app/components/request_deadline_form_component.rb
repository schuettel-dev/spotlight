class RequestDeadlineFormComponent < ViewComponent::Base
  attr_reader :request_deadline

  with_collection_parameter :request_deadline

  def initialize(request_deadline:)
    @request_deadline = request_deadline
  end

  def text_color_class
    return 'text-gray-600' unless request_deadline.active?
  end
end
