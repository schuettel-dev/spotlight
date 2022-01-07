require 'test_helper'

class Admin::WeekdayTemplateListComponentTest < ViewComponent::TestCase
  test 'render' do
    render_inline new_component(weekday_templates: WeekdayTemplate.all)
    assert_selector 'ul li', count: 7
  end
end
