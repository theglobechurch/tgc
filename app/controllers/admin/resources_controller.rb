class Admin::ResourcesController < AdminController

  layout 'application', only: [:preview]

  def index
    @resources = resources
  end

  def show
    @resource = resource
  end

  def new
    @resource = Resource.new
  end

  def edit
    @resource = resource
  end

  def create
    @resource = Resource.new(resource_params)
    @resource.save
    # Respond with?
  end

  def update
    resource.attributes = resource_params
    resource.save
    # Respond with?
  end

  def preview
    @resource = resource
  end

private

  def resources
    # Might want to filter by type here later
    @resources ||= Resource.all
  end

  def resource
    @resource ||= resources.slug_find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(:title,
                                     :resource_type,
                                     :external_reference,
                                     :body,
                                     :introduction,
                                     :slug)
  end

end
