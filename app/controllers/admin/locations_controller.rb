class Admin::LocationsController < AdminController
  protect_from_forgery

  def create
    location = Location.new(location_params)
    if location.save
      render json: {
        id: location.id,
        location_str: location.to_s,
      }, status: :ok
    else
      render json: location, status: :internal_server_error
    end
  end

private

  def location_params
    params.require(:location).permit(:name,
                                     :address_line_1,
                                     :address_line_2,
                                     :city,
                                     :code)
  end
end
