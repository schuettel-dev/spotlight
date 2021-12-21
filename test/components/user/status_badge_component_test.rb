require 'test_helper'

class User::StatusBadgeComponentTest < ViewComponent::TestCase
  test 'render, status verified' do
    render_inline new_component(status: :verified)
    assert_selector '.text-green-500', count: 1
    assert_selector 'svg.heroicon-badge-check', count: 1
  end

  test 'render, status blocked' do
    render_inline new_component(status: :blocked)
    assert_selector '.text-rose-400', count: 1
    assert_selector 'svg.heroicon-ban', count: 1
  end

  test 'not render, status anything-else' do
    component = new_component(status: :anything_else)
    assert_not component.render?
  end
end
