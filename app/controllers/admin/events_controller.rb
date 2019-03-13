class Admin::EventsController < AdminController

  helper Admin::EventFormHelper

  def index
    @events = events
  end

  def show
    @event = event
  end

  def edit
    @event = event
    @location_json = location_json
  end

  def new
    @event = Event.unscoped.new
    @location_json = location_json
    2.times do
      @event.event_instances.build
    end
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Event saved"
      respond_with(:admin, @event)
    else
      render :new
    end
  end

  def update
    event.attributes = event_params
    if event.save
      flash[:notice] = "#{event} updated"
      redirect_to action: "index"
    else
      @location_json = location_json
      respond_with(:admin, event)
    end
  end

  def preview
    @event = event
  end

private

  def events
    @events ||= Event.unscoped.
                non_deleted
  end

  def event
    @event ||= events.
                 includes(:event_instances).
                 references(:event_instances).
                 where("end_datetime >= ?", Time.now).
                 slug_find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title,
                                  :description,
                                  :slug,
                                  :state_event,
                                  :location_id,
                                  :graphics_id,
                                  :link_url,
                                  event_instances_attributes: EventInstance.attribute_names.map(&:to_sym).push(:_destroy))
  end

  def location_json
    @location_json ||= Location.all.to_json(only: [:id],
                                            methods: [:location_str])
  end
end
