class HomepagesController < ApplicationController

  def index
    @latest_sermon = latest_sermon.decorate
  end

private

  def latest_sermon
    @latest_sermon ||= Resource.resource_type('recording').first
  end

end

