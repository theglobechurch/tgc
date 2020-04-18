class EventsController < ApplicationController
  layout 'application'

  def index
    img_location = 'static-banner/the-globe-church-preaching_'
    @sunday_service = sunday_service.decorate if sunday_service
    @banner = {
      "title" => 'Church life',
      "subtitle" => 'Join us at one of the upcoming events at The Globe Church',
      "image" => {
        "320": view_context.asset_path("#{img_location}320.jpg"),
        "640": view_context.asset_path("#{img_location}640.jpg"),
        "960": view_context.asset_path("#{img_location}960.jpg"),
        "1280": view_context.asset_path("#{img_location}1280.jpg"),
        "1920": view_context.asset_path("#{img_location}1920.jpg"),
        "2560": view_context.asset_path("#{img_location}2560.jpg"),
      },
    }
    @featured = EventInstance.
                  future.
                  flag_featured.
                  where.not(graphics_id: nil).
                  first
    @this_week = this_week
    @future_events = future_events
  end

  def show
    @event = event.decorate
    @banner = @event.banner
  end

  def instance
    @event_instance = event_instance.decorate

    if (@event_instance.nil?)
      render_not_found
    end

    @banner = @event_instance.banner
    @banner['size'] = "blurred"
  end

private

  def this_week
    @this_week ||= EventInstance.all
                    .joins(:event)
                    .where('events.state': 'published')
                    .where("end_datetime >= ?", Time.now)
                    .where("end_datetime < ?", Time.now + 1.week)
                    .order(:start_datetime)
  end

  def future_events
    @future_events ||= EventInstance.all
                        .joins(:event)
                        .where('events.state': 'published')
                        .where("end_datetime >= ?", Time.now + 1.week)
                        .order(:start_datetime)

  end

  def events
    @events ||= Event.all
  end

  def event
    @event ||= events.slug_find(params[:id])
  end

  def event_instance
    # if it doesn't have a slug then look up by date
    if !params[:date].nil?
      @event_instance ||= EventInstance.joins(:event)
                            .where("events.slug = ?", params[:id])
                            .where("to_date(event_instances.start_datetime::text, 'YYYY-MM-DD') = ?", params[:date].to_date)
                            .first
    else 
      @event_instance ||= EventInstance.joins(:event)
                            .where("events.slug = ?", params[:id])
                            .where("event_instances.slug = ?", params[:instance_id])
                            .first
    end
  end

  def sunday_service
    @sunday_service ||= EventInstance
                          .future
                          .joins(:event)
                          .where('events.church_service': true)
                          .first
  end
end
