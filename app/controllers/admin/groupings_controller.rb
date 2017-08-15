class Admin::GroupingsController < AdminController

  helper Admin::GroupTypeHelper

  layout 'application', only: ['preview']

  def index
    @groupings = groupings
  end

  def show
    @grouping = grouping
  end

  def new
    @grouping = Grouping.new
  end

  def edit
    @grouping = grouping
  end

  def create
    @grouping = Grouping.new(grouping_params)
    @grouping.save
    flash[:notice] = "Grouping saved"
    respond_with(:admin, @grouping)
  end

  def update
    grouping.attributes = grouping_params
    grouping.save
    flash[:notice] = "Grouping updated"
    respond_with(:admin, @grouping)
  end

  def preview
    @grouping = grouping
  end

private

  def groupings
    @groupings ||= Grouping.all
  end

  def grouping
    @grouping ||= groupings.slug_find(params[:id])
    if (!@grouping)
      redirect_to admin_groupings_path
    end
    @grouping
  end

  def grouping_params
    params.require(:grouping).permit(:title,
                                     :description,
                                     :group_type,
                                     :start_date,
                                     :end_date,
                                     :slug,
                                     :state_event,
                                     :graphics_id)
  end
end
