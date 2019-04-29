class PodcastsController < ApplicationController
  layout 'application'
  # render template: "podcasts/index"

  def index
    @title = "All recordings from The Globe Church"
    @recordings = all_recordings
    respond
  end

  def sermon
    @title = "The Globe Church Sermons"
    @recordings = sermons
    respond
  end

  def show
    @recording = series
    if @recording.length >= 1
      @title = "The Globe Church: " + @recording.first.groupings.first.title
      @artwork = @recording.
                 first.
                 groupings.
                 first.
                 graphic.
                 background_image_thumbnail_2x.try('remote_url')
      respond
    else
      redirect_to preaching_path
    end
  end

private

  def respond(redirect_route: preaching_path)
    respond_to do |format|
      format.rss  { render layout: false, template: "podcasts/index" }
      format.html { redirect_to redirect_route }
    end
  end

  def all_recordings
    @recordings ||= Resource.
                    recording.
                    includes(:person, :upload).
                    where.not(display_date: nil).
                    order(display_date: :desc)
  end

  def sermons
    @recordings ||= all_recordings.
                    joins(:groupings).
                    where('groupings.group_type': 'Preaching')
  end

  def series
    @recordings ||= all_recordings.
                    joins(:groupings).
                    where('groupings.slug': params[:id])
  end

end
