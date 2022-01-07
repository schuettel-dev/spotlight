require 'test_helper'

class Admin::WeekdayTemplatesControllerTest < ActionDispatch::IntegrationTest
  test 'PUT update' do
    sign_in(users(:marge))

    weekday_template = weekday_templates(:monday)

    assert_changes -> { weekday_template.active? }, to: false do
      assert_changes -> { I18n.l(weekday_template.time, format: :day_time_only) }, to: '11:00' do
        put admin_weekday_template_path(weekday_template),
            params: { weekday_template: { active: '0', time: '11:00' } }
        weekday_template.reload
      end
    end

    follow_redirect!
    assert_response :success
  end

  test 'cannot PUT update, if not admin' do
    sign_in(users(:bart))

    weekday_template = weekday_templates(:monday)

    assert_no_changes -> { weekday_template.updated_at } do
      put admin_weekday_template_path(weekday_template),
          params: { weekday_template: { active: '0', time: '11:00' } }
      weekday_template.reload
    end

    follow_redirect!
    assert_response :success

    assert_equal 'Only admins can access this.', flash[:alert]
  end
end
