class Admin::GraphicsController < AdminController
  protect_from_forgery except: :create

  def create
    graphic = Graphic.new(background_image: params[:attachment][:file])

    if graphic.save
      render json: graphic, status: 200
    else
      render json: graphic, status: 500
    end
  end

end
