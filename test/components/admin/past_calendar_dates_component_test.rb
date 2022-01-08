require 'test_helper'

class Admin::PastCalendarDatesComponentTest < ViewComponent::TestCase
  test '#render, multiple' do
    render_inline(new_component(calendar_dates: calendar_dates(:monday, :tuesday)))
    assert_selector 'ul li', count: 2
  end

  test '#render, not if no calendar dates' do
    component = new_component(calendar_dates: [])
    assert_not component.render?
  end
end
