require 'test_helper'

class RequestFlowSectionComponentTest < ViewComponent::TestCase
  test 'render, awaiting light requests' do
    travel_to '2001-01-04 10:00:00 +01:00' do
      calendar_date = calendar_dates(:thursday)
      assert_not calendar_date.caretaker_informed?

      render_inline new_component(calendar_date: calendar_date)

      assert_collecting_requests text: 'Collecting requests'
      assert_contacting_caretaker text: 'Sending'
      assert_decision text: 'Confirmation / dismissal'
    end
  end

  test 'render, requesting light' do
    assert false
  end

  test 'render, light requested' do
    assert false, 'todo'
  end

  test 'render, light confirmed' do
    assert false, 'todo'
  end

  test 'render, light dismissed' do
    assert false, 'todo'
  end

  test 'not render, not active' do
    travel_to '2001-01-06 10:00:00 +01:00' do
      calendar_date = CalendarDate.for_today

      component = new_component(calendar_date: calendar_date)
      assert_not component.render?
    end
  end

  test 'not render, not requested until deadline' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      calendar_date = calendar_dates(:thursday)
      calendar_date.light_requests.delete_all

      component = new_component(calendar_date: calendar_date)
      assert_not component.render?
    end
  end

  private

  def assert_collecting_requests(text:)
    find_list_item_for('.collecting-requests').tap do |element|
      assert false
    end
  end

  def assert_contacting_caretaker(text:)
    find_list_item_for('.contacting-caretaker').tap do |element|
      assert false
    end
  end

  def assert_decision(text:)
    find_list_item_for('.decision').tap do |element|
      assert false
    end
  end
end
