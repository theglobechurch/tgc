class HomepagesController < ApplicationController
  def index
    img_path = 'static-banner/the-globe-church-logo'
    @latest_sermon = latest_sermon.decorate if latest_sermon
    @banner = {
      "title" => 'The Globe Church',
      "subtitle" => 'A church for the Southbank',
      "image" => {
        "320": view_context.asset_path("#{img_path}_320.jpg"),
        "640": view_context.asset_path("#{img_path}_640.jpg"),
        "960": view_context.asset_path("#{img_path}_960.jpg"),
        "1280": view_context.asset_path("#{img_path}_1280.jpg"),
        "1920": view_context.asset_path("#{img_path}_1920.jpg"),
        "2560": view_context.asset_path("#{img_path}_2560.jpg"),
      },
      "size" => 'none',
    }
  end

private

  def latest_sermon
    @latest_sermon ||= resources.
                       joins(:groupings).
                       where('groupings.group_type': 'series').
                       resource_type('recording').
                       order('display_date DESC NULLS LAST').
                       first
  end

end
