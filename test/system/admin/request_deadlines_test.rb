require 'application_system_test_case'

class Admin::RequestDeadlinesTest < ApplicationSystemTestCase
  test 'show request deadlines' do
    sign_in_as :marge
    navigate_to_admin_request_deadliens

    assert_link 'Back', href: '/admin/configuration'

    assert_selector 'h2', text: 'Request deadlines'
    assert_request_deadline 'Monday', true, '15:00'
    assert_request_deadline 'Tuesday', true, '16:00'
    assert_request_deadline 'Wednesday', true, '17:00'
    assert_request_deadline 'Thursday', true, '16:30'
    assert_request_deadline 'Friday', true, '14:30'
    assert_request_deadline 'Saturday', false, '10:00'
    assert_request_deadline 'Sunday', false, '00:00'
  end

  test 'changes request deadline for wednesday with JS' do
    using_browser do
      sign_in_as :marge
      navigate_to_admin_request_deadliens

      element = find_request_deadline_for('Wednesday')
      assert element.has_text?('17:00')

      within(element) do
        open_form
        select '17:45', from: 'Time'
        click_on 'Update time'
      end

      assert find_request_deadline_for('Wednesday').has_text?('17:45')
    end
  end

  test 'deactivates request deadline for wednesday with JS' do
    using_browser do
      sign_in_as :marge
      navigate_to_admin_request_deadliens

      element = find_request_deadline_for('Wednesday')

      within(element) do
        uncheck 'Weekday is activated'
      end

      assert_request_deadline 'Wednesday', false, '17:00'
    end
  end

  test 'forms stay opened after leaving and returning to page' do
    using_browser do
      sign_in_as :marge
      navigate_to_admin_request_deadliens

      within find_request_deadline_for('Tuesday') do
        assert_form_closed
        open_form
        assert_form_opened
      end

      click_on 'Back'
      click_on 'Request deadlines'

      within find_request_deadline_for('Tuesday') do
        assert_form_opened
      end
    end
  end

  private

  def navigate_to_admin_request_deadliens
    navigate_to 'Admin'
    click_on 'Request deadlines'
  end

  def assert_request_deadline(weekday, active, time)
    find_request_deadline_for(weekday).tap do |element|
      assert element.has_text?(weekday), "Should have text '#{weekday}'"

      if active
        assert element.has_checked_field?('Weekday is activated'), "#{weekday} should be activated"
        assert element.has_select?('Time', selected: time), "#{weekday} should have selected time '#{time}'"
      else
        assert element.has_unchecked_field?('Weekday is activated'), "#{weekday} should NOT be activated"
        assert element.has_text?(time), "#{weekday} should have time '#{time}'"
      end
    end
  end

  def find_request_deadline_for(weekday)
    find('li', text: weekday)
  end

  def open_form
    find('svg.heroicon-chevron-down').click
  end

  def assert_form_closed
    assert_selector 'svg.heroicon-chevron-down', count: 1
    assert_no_selector 'svg.heroicon-chevron-up'
    assert_no_button 'Update time'
  end

  def assert_form_opened
    assert_no_selector 'svg.heroicon-chevron-down'
    assert_selector 'svg.heroicon-chevron-up', count: 1
    assert_button 'Update time'
  end
end
