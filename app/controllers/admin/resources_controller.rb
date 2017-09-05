class Admin::ResourcesController < AdminController

  helper Admin::ResourceTypeHelper
  helper Admin::BibleHelper

  layout 'application', only: [:preview]

  def index
    @resources = resources
  end

  def show
    @resource = resource
  end

  def new
    @uploads = Upload.all
    @groupings = Grouping.published
    @resource = Resource.new
  end

  def edit
    @uploads = Upload.all
    @groupings = Grouping.published
    @resource = resource
  end

  def create
    @resource = Resource.new(resource_params)
    @resource.save
    flash[:notice] = "Resource saved"
    respond_with(:admin, @resource)
  end

  def update
    resource.attributes = resource_params
    resource.save
    flash[:notice] = "Resource updated"
    @groupings = Grouping.published
    respond_with(:admin, resource)
  end

  def preview
    @resource = resource.decorate
    @banner = @resource.banner
  end

private

  def resources
    # Might want to filter by type here later
    @resources ||= Resource.unscoped.non_deleted
  end

  def resource
    @resource ||= resources.slug_find(params[:id])
    unless @resource
      redirect_to admin_resources_path
    end
    @resource
  end

  def resource_params
    params.require(:resource).permit(:title,
                                     :resource_type,
                                     :external_reference,
                                     :body,
                                     :introduction,
                                     :slug,
                                     :state_event,
                                     :display_date,
                                     :uploads_id,
                                     :graphics_id,
                                     :people_id,
                                     :reference_book,
                                     :reference_book_start_ch,
                                     :reference_book_end_ch,
                                     :reference_book_start_v,
                                     :reference_book_end_v,
                                     grouping_ids: [])
  end

end
