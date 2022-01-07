require 'test_helper'

class Admin::ConfigurationsShowComponentTest < ViewComponent::TestCase
  test 'render' do
    render_inline Admin::ConfigurationsShowComponent.new
    assert_link 'Users', href: '/admin/users'
    assert_link 'Request deadlines', href: '/admin/weekday_templates'
  end
end
