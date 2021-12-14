require 'test_helper'

class Admin::RequestDeadlinesControllerTest < ActionDispatch::IntegrationTest
  test 'PUT update' do
    sign_in(users(:marge))

    request_deadline = request_deadlines(:monday)

    assert_changes -> { request_deadline.active? }, to: false do
      assert_changes -> { I18n.l(request_deadline.time, format: :day_time_only) }, to: '11:00' do
        put admin_request_deadline_path(request_deadline),
            params: { request_deadline: { active: '0', time: '11:00' } }
        request_deadline.reload
      end
    end
  end
end
