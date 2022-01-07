require 'test_helper'

class LightRequestsComponentTest < ViewComponent::TestCase
  test 'render, awaiting light requests, multiple light requests' do
    travel_to '2001-01-04 16:25:00 +01:00' do
      render_inline new_component(calendar_date: calendar_dates(:thursday))
      assert_selector 'svg', count: 6
      assert_text 'There are 6 requests for today.'
    end
  end

  test 'render, awaiting light requests, no light requests' do
    travel_to '2001-01-04 16:25:00 +01:00' do
      calendar_date = calendar_dates(:thursday)
      calendar_date.light_requests.delete_all

      render_inline new_component(calendar_date: calendar_date)
      assert_selector 'svg', count: 0
      assert_text "There aren't any requests for today yet."
    end
  end

  test 'render, after request time window end, multiple light requests' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      render_inline new_component(calendar_date: calendar_dates(:thursday))
      assert_selector 'svg', count: 6
      assert_text 'There were 6 requests for today.'
    end
  end

  test 'render, after request time window end, no light requests' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      calendar_date = calendar_dates(:thursday)
      calendar_date.light_requests.delete_all

      render_inline new_component(calendar_date: calendar_dates(:thursday))
      assert_selector 'svg', count: 0
      assert_text "There weren't any requests for today."
    end
  end

  test 'not render, request window not active' do
    travel_to '2001-01-06 10:00:00 +01:00' do
      component = new_component(calendar_date: CalendarDate.find_or_create_for_today)
      assert_not component.render?
    end
  end

  test 'not render, before request window' do
    travel_to '2001-01-03 23:55:00 +01:00' do
      component = new_component(calendar_date: calendar_dates(:thursday))
      assert_not component.render?
    end
  end
end
