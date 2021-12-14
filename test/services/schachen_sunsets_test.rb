require 'test_helper'

class SchachenSunsetsTest < ActiveSupport::TestCase
  test '.on' do
    assert_equal '2020-02-01 16:29:05 UTC', sunset_for('2020-02-01').to_s
    assert_equal '2020-08-01 19:02:16 UTC', sunset_for('2020-08-01').to_s
  end

  private

  def sunset_for(date)
    SchachenSunsets.on(Date.parse(date))
  end
end
