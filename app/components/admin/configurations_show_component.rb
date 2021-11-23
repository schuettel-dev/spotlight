class Admin::ConfigurationsShowComponent < ViewComponent::Base
  attr_reader :request_deadlines

  def initialize(request_deadlines:)
    @request_deadlines = request_deadlines
  end
end
