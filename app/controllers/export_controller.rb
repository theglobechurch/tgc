class ExportController < ApplicationController
  layout 'application'

  def blog
    @articles = Resource.blog.order(display_date: :desc).decorate

    respond_to do |format|
      format.rss { render :layout => false }
    end

  end

  def audio
    @recordings = Resource.
                  recording.
                  includes(:person, :upload, :graphic, :groupings).
                  where.not(display_date: nil).
                  order(display_date: :desc).
                  decorate

    render json: ActiveModelSerializers::SerializableResource.new(
      @recordings,
      each_serializer: RecordingSerializer
    ).serializable_hash
  end

  def series
    @series = Grouping.includes(:graphic)

    render json: ActiveModelSerializers::SerializableResource.new(
      @series,
      each_serializer: SeriesSerializer
    ).serializable_hash
  end

end
