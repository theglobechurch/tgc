class Admin::UploadsController < AdminController
  protect_from_forgery except: :create

  def create
    up = Upload.new(file: params[:attachment][:file])
    if up.save
      render json: up, status: 200
    else
      render json: up, status: 500
    end
  end

end
