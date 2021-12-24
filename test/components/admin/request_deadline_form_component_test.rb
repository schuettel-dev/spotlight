require 'test_helper'

class Admin::RequestDeadlineFormComponentTest < ViewComponent::TestCase
  test 'render' do
    component = new_component(request_deadline: request_deadlines(:wednesday))
    render_inline component

    assert_select 'Time', selected: '17:00'
    assert_button 'Update time'
  end

  test 'not render' do
    component = new_component(request_deadline: request_deadlines(:wednesday))
    assert component.render?

    component = new_component(request_deadline: request_deadlines(:saturday))
    assert_not component.render?
  end

  test '#selected_time' do
    component = new_component(request_deadline: request_deadlines(:wednesday))
    assert_equal '17:00', component.selected_time
  end

  test '#time_select_options' do
    component = new_component(request_deadline: request_deadlines(:wednesday))
    component.time_select_options.tap do |options|
      assert_equal 41, options.count
      assert_equal '10:00', options.first
      assert_equal '10:15', options.second
      assert_equal '19:45', options.second_to_last
      assert_equal '20:00', options.last
    end
  end
end
