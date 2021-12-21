require 'test_helper'

class Admin::UserInfoComponentTest < ViewComponent::TestCase
  test 'render, unverified' do
    render_inline new_component(user: users(:milhouse))
    assert_text 'milhouse'
    assert_selector 'svg.heroicon-ban', count: 0
    assert_selector 'svg.heroicon-badge-check', count: 0
    assert_text '4 light requests'
  end

  test 'render, blocked' do
    render_inline new_component(user: users(:kearney))
    assert_text 'kearney'
    assert_selector 'svg.heroicon-ban', count: 1
    assert_selector 'svg.heroicon-badge-check', count: 0
    assert_text '1 light request'
  end

  test 'render, verified non-admin' do
    render_inline new_component(user: users(:bart))
    assert_text 'bart'
    assert_selector 'svg.heroicon-ban', count: 0
    assert_selector 'svg.heroicon-badge-check', count: 1
    assert_text '4 light request'
  end

  test 'render, admin' do
    render_inline new_component(user: users(:marge))
    assert_text 'marge'
    assert_text 'Admin'
    assert_selector 'svg.heroicon-ban', count: 0
    assert_selector 'svg.heroicon-badge-check', count: 1
    assert_text '0 light request'
  end
end
