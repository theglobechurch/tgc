class EventsController < ApplicationController
  layout 'application'

  def index
    @events = events
    @today = Time.now
  end

private
  def events
    @events ||= EventInstance.all
                  .joins(:event)
                  .where('events.state': 'published')
                  .where("end_datetime >= ?", Date.current)
                  .order(:start_datetime)
  end
end
