class PodcastsController < ApplicationController
  layout 'application'
  # render template: "podcasts/index"

  def index
    @recordings = all_recordings
    respond
  end

  def sermon
    @recordings = sermons
    respond
  end

  def show
    @recording = series
    respond
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
                    where('groupings.group_type': 'series')
  end

  def series
    @recordings ||= all_recordings.
                    joins(:groupings).
                    where('groupings.slug': params[:id])
  end

end
