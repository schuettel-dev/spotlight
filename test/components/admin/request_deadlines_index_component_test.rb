require 'test_helper'

class Admin::RequestDeadlinesIndexComponentTest < ViewComponent::TestCase
  test 'render' do
    component = Admin::RequestDeadlinesIndexComponent.new(request_deadlines: RequestDeadline.ordered)
    render_inline component

    assert_link 'Back'
    assert_selector 'h2', text: 'Request deadlines'
    assert_selector '#admin_request_deadlines li', count: 7
  end
end
