require 'test_helper'

# rubocop:disable Layout/SpaceBeforeComma
class DeadlinesSectionComponentTest < ViewComponent::TestCase
  test 'render general' do
    render_inline(new_component)
    assert_selector 'h2', text: 'General deadlines'
    assert_weekday_template_time 'Monday'   , '15:00'
    assert_weekday_template_time 'Tuesday'  , '16:00'
    assert_weekday_template_time 'Wednesday', '17:00'
    assert_weekday_template_time 'Thursday' , '16:30'
    assert_weekday_template_time 'Friday'   , '14:30'
    assert_weekday_template_time 'Saturday' , 'Not available'
    assert_weekday_template_time 'Sunday'   , 'Not available'
  end

  test 'render monday' do
    travel_to '2001-01-01 10:00:00 +01:00' do
      render_inline(new_component)
      assert_weekday_template_css_class 'Monday'   , :current
      assert_weekday_template_css_class 'Tuesday'  , :active
      assert_weekday_template_css_class 'Wednesday', :active
      assert_weekday_template_css_class 'Thursday' , :active
      assert_weekday_template_css_class 'Friday'   , :active
      assert_weekday_template_css_class 'Saturday' , :inactive
      assert_weekday_template_css_class 'Sunday'   , :inactive
    end
  end

  test 'render tuesday' do
    travel_to '2001-01-02 10:00:00 +01:00' do
      render_inline(new_component)
      assert_weekday_template_css_class 'Monday'   , :active
      assert_weekday_template_css_class 'Tuesday'  , :current
      assert_weekday_template_css_class 'Wednesday', :active
      assert_weekday_template_css_class 'Thursday' , :active
      assert_weekday_template_css_class 'Friday'   , :active
      assert_weekday_template_css_class 'Saturday' , :inactive
      assert_weekday_template_css_class 'Sunday'   , :inactive
    end
  end

  test 'render wednesday' do
    travel_to '2001-01-03 10:00:00 +01:00' do
      render_inline(new_component)
      assert_weekday_template_css_class 'Monday'   , :active
      assert_weekday_template_css_class 'Tuesday'  , :active
      assert_weekday_template_css_class 'Wednesday', :current
      assert_weekday_template_css_class 'Thursday' , :active
      assert_weekday_template_css_class 'Friday'   , :active
      assert_weekday_template_css_class 'Saturday' , :inactive
      assert_weekday_template_css_class 'Sunday'   , :inactive
    end
  end

  test 'render thursday' do
    travel_to '2001-01-04 10:00:00 +01:00' do
      render_inline(new_component)
      assert_weekday_template_css_class 'Monday'   , :active
      assert_weekday_template_css_class 'Tuesday'  , :active
      assert_weekday_template_css_class 'Wednesday', :active
      assert_weekday_template_css_class 'Thursday' , :current
      assert_weekday_template_css_class 'Friday'   , :active
      assert_weekday_template_css_class 'Saturday' , :inactive
      assert_weekday_template_css_class 'Sunday'   , :inactive
    end
  end

  test 'render friday' do
    travel_to '2001-01-05 10:00:00 +01:00' do
      render_inline(new_component)
      assert_weekday_template_css_class 'Monday'   , :active
      assert_weekday_template_css_class 'Tuesday'  , :active
      assert_weekday_template_css_class 'Wednesday', :active
      assert_weekday_template_css_class 'Thursday' , :active
      assert_weekday_template_css_class 'Friday'   , :current
      assert_weekday_template_css_class 'Saturday' , :inactive
      assert_weekday_template_css_class 'Sunday'   , :inactive
    end
  end

  test 'render saturday' do
    travel_to '2001-01-06 10:00:00 +01:00' do
      render_inline(new_component)
      assert_weekday_template_css_class 'Monday'   , :active
      assert_weekday_template_css_class 'Tuesday'  , :active
      assert_weekday_template_css_class 'Wednesday', :active
      assert_weekday_template_css_class 'Thursday' , :active
      assert_weekday_template_css_class 'Friday'   , :active
      assert_weekday_template_css_class 'Saturday' , :inactive
      assert_weekday_template_css_class 'Sunday'   , :inactive
    end
  end

  test 'render sunday' do
    travel_to '2001-01-07 10:00:00 +01:00' do
      render_inline(new_component)
      assert_weekday_template_css_class 'Monday'   , :active
      assert_weekday_template_css_class 'Tuesday'  , :active
      assert_weekday_template_css_class 'Wednesday', :active
      assert_weekday_template_css_class 'Thursday' , :active
      assert_weekday_template_css_class 'Friday'   , :active
      assert_weekday_template_css_class 'Saturday' , :inactive
      assert_weekday_template_css_class 'Sunday'   , :inactive
    end
  end

  private

  def weekday_templates_css_classes
    {
      current: 'request-deadlines--weekday-current',
      active: 'request-deadlines--weekday-active',
      inactive: 'request-deadlines--weekday-inactive'
    }
  end

  def assert_weekday_template_time(weekday, time)
    find_weekday_template_row(weekday).tap do |weekday_template_row|
      weekday_template_row.assert_text time
    end
  end

  def assert_weekday_template_css_class(weekday, key)
    find_weekday_template_row(weekday).tap do |weekday_template_row|
      assert_match weekday_templates_css_classes[key], weekday_template_row['class']
    end
  end

  def find_weekday_template_row(weekday)
    page.find_all('.request-deadline-row')
        .find { |element| element.text.include?(weekday) }
  end
end
# rubocop:enable Layout/SpaceBeforeComma
