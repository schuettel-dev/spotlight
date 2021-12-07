require 'test_helper'

class LightRequestsIconsComponentTest < ViewComponent::TestCase
  test 'not render, 0 light request' do
    component = new_component(light_requests: LightRequest.none)
    assert_not component.render?
  end

  test 'render, 1 light request' do
    component = new_component(light_requests: LightRequest.take(1))
    render_inline component

    assert_selector 'svg', count: 1
  end

  test 'render, multiple light request' do
    component = new_component(light_requests: LightRequest.take(3))
    render_inline component

    assert_selector 'svg', count: 3
  end
end
