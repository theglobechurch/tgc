class Admin::ApiController < AdminController

  def index; end

  def resource
    if params[:q].present? && params[:q].length > 2
      render json: resources.search(params[:q])
    else
      render plain: ""
    end
  end

private

  def resources
    @resources ||= Resource.all
  end

end
