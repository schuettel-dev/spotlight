require 'test_helper'

class Admin::WeekdayTemplateFormComponentTest < ViewComponent::TestCase
  test 'render' do
    component = new_component(weekday_template: weekday_templates(:wednesday))
    render_inline component

    assert_select 'Time', selected: '17:00'
    assert_button 'Update time'
  end

  test 'not render' do
    component = new_component(weekday_template: weekday_templates(:wednesday))
    assert component.render?

    component = new_component(weekday_template: weekday_templates(:saturday))
    assert_not component.render?
  end

  test '#selected_request_window_ends_at' do
    component = new_component(weekday_template: weekday_templates(:wednesday))
    assert_equal '17:00', component.selected_request_window_ends_at
  end

  test '#request_window_ends_at_select_options' do
    component = new_component(weekday_template: weekday_templates(:wednesday))
    component.request_window_ends_at_select_options.tap do |options|
      assert_equal 41, options.count
      assert_equal '10:00', options.first
      assert_equal '10:15', options.second
      assert_equal '19:45', options.second_to_last
      assert_equal '20:00', options.last
    end
  end
end
