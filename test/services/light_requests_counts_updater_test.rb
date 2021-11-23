require 'test_helper'

class LightRequestsCountsUpdaterTest < ActiveSupport::TestCase
  test 'update, all' do
    reset_light_requests_counts!

    monday, thursday = calendar_dates(:monday, :thursday)
    bart, kearney = users(:bart, :kearney)

    assert_equal 0, monday.light_requests_count
    assert_equal 0, thursday.light_requests_count
    assert_equal 0, bart.light_requests_count
    assert_equal 0, kearney.light_requests_count

    LightRequestsCountsUpdater.new.call

    assert_equal 9, monday.reload.light_requests_count
    assert_equal 6, thursday.reload.light_requests_count
    assert_equal 4, bart.reload.light_requests_count
    assert_equal 1, kearney.reload.light_requests_count
  end

  test 'update, scope on single light_request' do
    reset_light_requests_counts!

    monday, thursday = calendar_dates(:monday, :thursday)
    bart, kearney = users(:bart, :kearney)
    barts_light_request_on_thursday = light_requests(:thursday_bart)

    assert_equal 0, monday.light_requests_count
    assert_equal 0, thursday.light_requests_count
    assert_equal 0, bart.light_requests_count
    assert_equal 0, kearney.light_requests_count

    LightRequestsCountsUpdater.new(barts_light_request_on_thursday).call

    assert_equal 0, monday.reload.light_requests_count
    assert_equal 6, thursday.reload.light_requests_count
    assert_equal 4, bart.reload.light_requests_count
    assert_equal 0, kearney.reload.light_requests_count
  end

  private

  def reset_light_requests_counts!
    CalendarDate.update_all('light_requests_count = 0')
    User.update_all('light_requests_count = 0')
  end
end
