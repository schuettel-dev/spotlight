require 'test_helper'

class TitleComponentTest < ViewComponent::TestCase
  test '#render' do
    render_inline(new_component)
    assert_text 'SPOTLIGHT'
    assert_text 'at Skatepark Schachen, Aarau'
  end
end
