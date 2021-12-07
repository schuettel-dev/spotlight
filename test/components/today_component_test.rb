require 'test_helper'

class TodayComponentTest < ViewComponent::TestCase
  test 'render, active, request window open' do
    travel_to '2001-01-04 10:00:00 +01:00' do
      render_component_for_thursday

      assert_section 'date'
      assert_section 'status'
      assert_section 'requests'
      assert_section 'request-flow'
      assert_section 'deadlines'
    end
  end

  test 'render, active, request window closed, having request' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      render_component_for_thursday

      assert_section 'date'
      assert_section 'status'
      assert_section 'requests'
      assert_section 'request-flow'
      assert_section 'deadlines'
    end
  end

  test 'render, active, request window closed, NOT having request' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      calendar_dates(:thursday).light_requests.delete_all

      render_component_for_thursday

      assert_section 'date'
      assert_section 'status'
      assert_section 'requests'
      assert_no_section 'request-flow'
      assert_section 'deadlines'
    end
  end

  test 'render, not active' do
    travel_to '2001-01-06 10:0:00 +01:00' do
      render_inline(new_component(calendar_date: CalendarDate.for_today, user_light_request: LightRequest.new))

      assert_section 'date'
      assert_section 'status'
      assert_no_section 'requests'
      assert_no_section 'request-flow'
      assert_section 'deadlines'
    end
  end

  private

  def render_component_for_thursday
    render_inline(new_component(calendar_date: calendar_dates(:thursday), user_light_request: LightRequest.new))
  end

  def assert_section(section_class_name)
    assert_selector("section.#{section_class_name}")
  end

  def assert_no_section(section_class_name)
    assert_no_selector("section.#{section_class_name}")
  end
end
