class Admin::LivestreamsController < AdminController

  layout 'application', only: [:preview]

  def index
    @livestreams = livestreams
  end

  def new
    @livestream = Livestream.new
  end

  def edit
    @livestream = livestream
  end

  def create
    @livestream = Livestream.new(livestream_params)
    if @livestream.save
      flash[:notice] = "Created"
      redirect_to action: "index"
    else
      respond_with(:admin, @livestream)
    end
  end

  def update
    livestream.attributes = livestream_params
    if livestream.save
      flash[:notice] = "Livestream details updated"
      redirect_to action: "index"
    else
      respond_with(:admin, livestream)
    end
  end

private

  def livestreams
    @livestreams ||= Livestream.all
  end

  def livestream
    @livestream ||= livestreams.find(params[:id])
  end

  def livestream_params
    params.require(:livestream).permit(:youtubeId,
                                        :live_at)
  end

end
