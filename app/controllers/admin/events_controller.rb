class Admin::EventsController < AdminController

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
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Event saved"
      respond_with(:admin, @event)
    else
      render 'new'
    end
  end

  def update

  end

  def preview
    @event = event
  end

private

  def events
    @events ||= Event.unscoped.all
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
                                  :graphics_id)
  end
end
