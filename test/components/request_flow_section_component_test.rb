require 'test_helper'

class RequestFlowSectionComponentTest < ViewComponent::TestCase
  test 'render, awaiting light requests' do
    travel_to '2001-01-04 10:00:00 +01:00' do
      calendar_date = calendar_dates(:thursday)
      assert_not calendar_date.caretaker_informed?

      render_inline new_component(calendar_date: calendar_date)

      assert_collecting_requests text: 'Collecting requests'
      assert_contacting_caretaker text: 'Sending request to caretaker at 16:30'
      assert_decision text: 'Confirmation / dismissal'
    end
  end

  test 'render, requesting light' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      calendar_date = calendar_dates(:thursday)
      assert_not calendar_date.caretaker_informed?
      assert calendar_date.request_window.time_window_end.past?

      render_inline new_component(calendar_date: calendar_date)

      assert_collecting_requests text: 'Collecting requests'
      assert_contacting_caretaker text: 'Sending request to caretaker at 16:30'
      assert_decision text: 'Confirmation / dismissal'
    end
  end

  test 'render, light requested' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      calendar_date = calendar_dates(:thursday)
      calendar_date.caretaker_informed!
      assert calendar_date.request_window.time_window_end.past?

      render_inline new_component(calendar_date: calendar_date)

      assert_collecting_requests text: 'Collecting requests'
      assert_contacting_caretaker text: 'Request sent to caretaker at 16:35'
      assert_decision text: 'Awaiting confirmation / dismissal'
    end
  end

  test 'render, light confirmed' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      calendar_date = calendar_dates(:thursday)
      calendar_date.caretaker_informed!
      calendar_date.caretaker_confirmed_light!

      render_inline new_component(calendar_date: calendar_date)

      assert_collecting_requests text: 'Collecting requests'
      assert_contacting_caretaker text: 'Request sent to caretaker at 16:35'
      assert_decision text: 'Light confirmed'
    end
  end

  test 'render, light dismissed' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      calendar_date = calendar_dates(:thursday)
      calendar_date.caretaker_informed!
      calendar_date.caretaker_dismissed_light!

      render_inline new_component(calendar_date: calendar_date)

      assert_collecting_requests text: 'Collecting requests'
      assert_contacting_caretaker text: 'Request sent to caretaker at 16:35'
      assert_decision text: 'Light requests have been dismissed'
    end
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
    assert_selector('li.collecting-requests') do |element|
      element.assert_text text, normalize_ws: true
    end
  end

  def assert_contacting_caretaker(text:)
    assert_selector('li.contacting-caretaker') do |element|
      element.assert_text text, normalize_ws: true
    end
  end

  def assert_decision(text:)
    assert_selector('li.decision') do |element|
      element.assert_text text, normalize_ws: true
    end
  end
end
