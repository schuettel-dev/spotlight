require 'test_helper'

class InformCaretakerServiceTest < ActiveSupport::TestCase
  test '#call!, deadline not due yet, caretaker not informed yet' do
    travel_to '2001-01-04 16:25:00 +01:00' do
      thursday = calendar_dates(:thursday)

      assert_no_changes -> { thursday.status } do
        InformCaretakerService.new(thursday).call!
        thursday.reset_status
      end
    end
  end

  test '#call!, deadline due, caretaker not informed yet' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      thursday = calendar_dates(:thursday)
      thursday.update(caretaker_informed_at: nil)

      assert_changes -> { thursday.status }, from: :requesting_light, to: :light_requested do
        InformCaretakerService.new(thursday).call!
        thursday.reset_status
      end
    end
  end

  test '#call!, deadline due, caretaker already informed' do
    travel_to '2001-01-04 16:35:00 +01:00' do
      thursday = calendar_dates(:thursday)

      assert_no_changes -> { thursday.status } do
        InformCaretakerService.new(thursday).call!
        thursday.reset_status
      end
    end
  end

  test '#call! different day' do
    travel_to '2001-01-03 16:35:00 +01:00' do
      thursday = calendar_dates(:thursday)
      thursday.update(caretaker_informed_at: nil)

      assert_no_changes -> { thursday.status } do
        InformCaretakerService.new(thursday).call!
        thursday.reset_status
      end
    end
  end
end
