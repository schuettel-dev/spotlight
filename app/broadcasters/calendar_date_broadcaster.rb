class CalendarDateBroadcaster
  include ActionView::RecordIdentifier
  include Turbo::Streams::Broadcasts
  include Turbo::Streams::StreamName

  def initialize(calendar_date)
    @calendar_date = calendar_date
  end

  def call
    broadcast_today
  end

  private

  def broadcast_today
    return unless calendar_date_today_in_zurich?

    broadcast_todays_status_frame
  end

  def broadcast_todays_status_frame
    component = StatusSectionComponent.new(calendar_date: @calendar_date)
    broadcast_replace_to(
      'today',
      target: 'todays-status-frame',
      html: ApplicationController.render(component, layout: false)
    )
  end


  def calendar_date_today_in_zurich?
    @calendar_date.date == CalendarService.today_in_zurich
  end
end
