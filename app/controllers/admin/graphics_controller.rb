class Admin::GraphicsController < AdminController
  protect_from_forgery except: :create

  def create
    graphic = Graphic.new(background_image: params[:attachment][:file])

    if graphic.save
      render json: graphic, status: :ok
    else
      render json: graphic, status: :internal_server_error
    end
  end

end
