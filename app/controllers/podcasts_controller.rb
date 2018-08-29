class PodcastsController < ApplicationController
  layout 'application'

  def index
    @recordings = resources.recording.where.not(display_date: nil).order(display_date: :desc).limit(10)

    respond_to do |format|
      format.rss  { render layout: false }
      format.html { redirect_to preaching_path }
    end
  end

private

  def resources
    @resources ||= Resource.all
  end

end
