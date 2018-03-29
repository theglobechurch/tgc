class HomepagesController < ApplicationController
  def index
    @latest_sermon = latest_sermon.decorate if latest_sermon
    @banner = {
      "title" => 'The Globe Church',
      "subtitle" => 'A church for the Southbank',
      "image" => {
        "320": view_context.asset_path("static-banner/the-globe-church-logo_320.jpg"),
        "640": view_context.asset_path("static-banner/the-globe-church-logo_640.jpg"),
        "960": view_context.asset_path("static-banner/the-globe-church-logo_960.jpg"),
        "1280": view_context.asset_path("static-banner/the-globe-church-logo_1280.jpg"),
        "1920": view_context.asset_path("static-banner/the-globe-church-logo_1920.jpg"),
        "2560": view_context.asset_path("static-banner/the-globe-church-logo_2560.jpg"),
      },
      "size" => 'none',
    }
  end

private

  def latest_sermon
    @latest_sermon ||= Resource.resource_type('recording').
                       order('display_date DESC NULLS LAST').
                       first
  end

end
