require 'test_helper'

class Admin::CalendarDateParamsTransformerTest < ActiveSupport::TestCase
  setup do
    @reference_date = DateTime.new(2001, 2, 3, 4, 5, 6)
  end

  test '#attributes, active' do
    attributes = service_attributes_with(calendar_date: { active: '1' })
    assert_equal({ active: '1' }, attributes.symbolize_keys)

    attributes = service_attributes_with(calendar_date: { active: '0' })
    assert_equal({ active: '0' }, attributes.symbolize_keys)
  end

  test '#attributes, decision: confirm' do
    travel_to @reference_date do
      attributes = service_attributes_with(calendar_date: { decision: 'confirm' })

      assert_equal(
        {
          caretaker_confirmed_light_at: @reference_date,
          caretaker_dismissed_light_at: nil
        },
        attributes.symbolize_keys
      )
    end
  end

  test '#attributes, decision: dismiss' do
    travel_to @reference_date do
      attributes = service_attributes_with(calendar_date: { decision: 'dismiss' })

      assert_equal(
        {
          caretaker_confirmed_light_at: nil,
          caretaker_dismissed_light_at: @reference_date
        },
        attributes.symbolize_keys
      )
    end
  end

  test '#attributes, decision: reset' do
    travel_to @reference_date do
      attributes = service_attributes_with(calendar_date: { decision: 'reset' })

      assert_equal(
        {
          caretaker_confirmed_light_at: nil,
          caretaker_dismissed_light_at: nil
        },
        attributes.symbolize_keys
      )
    end
  end

  test '#attributes, decision: unknown' do
    travel_to @reference_date do
      attributes = service_attributes_with(calendar_date: { decision: 'unknown' })

      assert_empty(attributes.symbolize_keys)
    end
  end

  test '#attributes, request_window_ends_at' do
    attributes = service_attributes_with(calendar_date: { request_window_ends_at: '12:34' })

    assert_equal(
      {
        request_window_ends_at: ''
      },
      attributes.symbolize_keys
    )
  end

  private

  def to_calendar_date_params(hash)
    ActionController::Parameters.new(hash)
  end

  def service_attributes_with(params)
    Admin::CalendarDateParamsTransformer.new(to_calendar_date_params(params)).attributes
  end
end
