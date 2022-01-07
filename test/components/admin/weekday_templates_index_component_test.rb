require 'test_helper'

class Admin::WeekdayTemplatesIndexComponentTest < ViewComponent::TestCase
  test 'render' do
    component = Admin::WeekdayTemplatesIndexComponent.new(weekday_templates: WeekdayTemplate.ordered)
    render_inline component

    assert_link 'Back'
    assert_selector 'h2', text: 'Request deadlines'
    assert_selector '#admin_weekday_templates li', count: 7
  end
end
