require 'test_helper'

class CalendarDate::StatusBadgeComponentTest < ViewComponent::TestCase
  test '#render, status: date_in_future' do
    render_inline(new_component(status: 'date_in_future'))
    assert_selector 'svg.heroicon-clock'
  end

  test '#render, status: awaiting_light_requests' do
    render_inline(new_component(status: 'awaiting_light_requests'))
    assert_selector 'svg.heroicon-collection'
  end

  test '#render, status: requesting_light' do
    render_inline(new_component(status: 'requesting_light'))
    assert_selector 'svg.heroicon-status-online'
  end

  test '#render, status: light_requested' do
    render_inline(new_component(status: 'light_requested'))
    assert_selector 'svg.heroicon-phone-outgoing'
  end

  test '#render, status: light_confirmed' do
    render_inline(new_component(status: 'light_confirmed'))
    assert_selector 'svg.heroicon-light-bulb'
  end

  test '#render, status: light_dismissed' do
    render_inline(new_component(status: 'light_dismissed'))
    assert_selector 'svg.heroicon-moon'
  end

  test '#render, status: not_requested_until_deadline' do
    render_inline(new_component(status: 'not_requested_until_deadline'))
    assert_selector 'svg.heroicon-moon'
  end

  test '#render, status: not_active_today' do
    render_inline(new_component(status: 'not_active_today'))
    assert_selector 'svg.heroicon-moon'
  end
end
