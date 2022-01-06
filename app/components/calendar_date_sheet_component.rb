class CalendarDateSheetComponent < ViewComponent::Base
  attr_reader :date

  def initialize(date:)
    @date = date
  end

  def month_name_short
    date.strftime('%b')
  end

  def day
    date.strftime('%d')
  end
end
