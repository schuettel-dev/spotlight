require 'test_helper'

class Admin::RequestDeadlineListItemComponentTest < ViewComponent::TestCase
  test 'render' do
    request_deadline = request_deadlines(:wednesday)

    render_inline new_component(request_deadline: request_deadline)

    assert_selector 'li', count: 1
    assert_checked_field 'Weekday is activated'
    assert_text 'Wednesday'
    assert_text '17:00'
    assert_selector 'svg.heroicon-chevron-down'
    assert_select 'Time', selected: '17:00'
    assert_button 'Update time'
  end

  test '#render_form?' do
    component = new_component(request_deadline: request_deadlines(:wednesday))
    assert component.render_form?, 'Should render form because Wednesday is activated'

    component = new_component(request_deadline: request_deadlines(:saturday))
    assert_not component.render_form?, 'Should NOT render form because Wednesday is activated'
  end

  test '#css_classes' do
    component = new_component(request_deadline: request_deadlines(:wednesday))
    assert_nil component.css_classes

    component = new_component(request_deadline: request_deadlines(:saturday))
    assert_equal 'text-gray-500', component.css_classes
  end
end
