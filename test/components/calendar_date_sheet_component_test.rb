require 'test_helper'

class CalendarDateSheetComponentTest < ViewComponent::TestCase
  test '#render' do
    render_inline(new_component(date: Date.new(2020, 12, 24)))
    assert_text 'Dec'
    assert_text '24'
  end
end
