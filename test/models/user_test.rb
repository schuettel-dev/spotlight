require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#request_light_for_today, new request, existing calendar date' do
    calendar_date = calendar_dates(:thursday) # 2021-05-13
    user = users(:todd)

    travel_to calendar_date.date do
      assert_difference(
        [
          -> { calendar_date.light_requests.count },
          -> { user.light_requests.count },
          -> { LightRequest.count }
        ], +1
      ) do
        assert_no_difference(-> { CalendarDate.count }) do
          assert user.request_light_for_today
          user.reload
          calendar_date.reload
        end
      end
    end
  end

  test '#request_light_for_today, existing request, existing calendar date' do
    calendar_date = calendar_dates(:thursday) # 2021-05-13
    user = users(:bart)

    travel_to calendar_date.date do
      assert_no_difference(
        [
          -> { CalendarDate.count },
          -> { LightRequest.count },
          -> { calendar_date.light_requests.count },
          -> { user.light_requests.count }
        ]
      ) do
        assert user.request_light_for_today
        user.reload
        calendar_date.reload
      end
    end
  end

  test '#request_light_for_today, new calendar date' do
    user = users(:bart)
    date = '2021-01-01'

    travel_to date do
      assert_difference(
        [
          -> { CalendarDate.count },
          -> { LightRequest.count },
          -> { user.light_requests.count }
        ], +1
      ) do
        assert user.request_light_for_today
        user.reload
      end

      calendar_date = CalendarDate.find_by!(date: date)
      assert_equal 1, calendar_date.light_requests.count
    end
  end

  test '#admin?' do
    assert_not User.new.admin?
    assert User.role_admin.new.admin?
    assert User.role_caretaker.new.admin?
    assert User.role_superadmin.new.admin?
  end

  test 'sanitizes mobile' do
    assert_sanitized_mobile '', ''
    assert_sanitized_mobile '0041791112233', '0041791112233'
    assert_sanitized_mobile '0041791112233', ' 0041791112233 '
    assert_sanitized_mobile '0041791112233', '41791112233'
    assert_sanitized_mobile '0041791112233', '+41 79 111 22 33'
    assert_sanitized_mobile '0041791112233', '0041 79 111 22 33'
  end

  private

  def assert_sanitized_mobile(expected, input)
    User.new(mobile: input).tap do |user|
      user.validate
      assert_equal expected, user.mobile
    end
  end
end
