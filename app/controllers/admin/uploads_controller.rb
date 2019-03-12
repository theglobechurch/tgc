class Admin::UploadsController < AdminController
  protect_from_forgery except: :create

  def create
    up = create_attachment(params[:upload_type],
                           params[:attachment][:file])
    if up.save
      render json: up, status: :ok
    else
      render json: up.errors.full_messages, status: :internal_server_error
    end
  end

private

  def create_attachment(type, file)
    case type
    when 'audio_file'
      Upload.new(file: file)
    else
      Image.new(file: file)
    end
  end
end
