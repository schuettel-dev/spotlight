require 'test_helper'

class HeroiconComponentTest < ViewComponent::TestCase
  test 'render' do
    render_inline(HeroiconComponent.new(:'dots-horizontal'))
    assert_selector 'svg', count: 1
  end

  test 'raise if icon not exists' do
    error = assert_raises(Errno::ENOENT) do
      render_inline(HeroiconComponent.new(:whoops))
    end

    assert_match /^No such file or directory/, error.message
  end
end
