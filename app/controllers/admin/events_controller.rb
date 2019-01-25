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
  end

  def new
    @event = Event.unscoped.new
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
    @event ||= events.slug_find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title,
                                  :description,
                                  :slug,
                                  :state_event,
                                  :location_id,
                                  :graphics_id,
                                  event_instances_attributes: EventInstance.attribute_names.map(&:to_sym).push(:_destroy))
  end
end
