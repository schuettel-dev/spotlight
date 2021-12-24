require 'test_helper'

class Admin::RequestDeadlineListComponentTest < ViewComponent::TestCase
  test 'render' do
    render_inline new_component(request_deadlines: RequestDeadline.all)
    assert_selector 'ul li', count: 7
  end
end
