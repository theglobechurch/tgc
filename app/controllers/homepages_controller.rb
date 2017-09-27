class HomepagesController < ApplicationController
  def index
    @latest_sermon = latest_sermon.decorate if latest_sermon
    @banner = {
      "title" => 'The Globe Church',
      "subtitle" => 'A church for the Southbank',
      "image" => {
        "320": view_context.asset_url("static-banner/southbank-320.jpg"),
        "640": view_context.asset_url("static-banner/southbank-640.jpg"),
        "960": view_context.asset_url("static-banner/southbank-960.jpg"),
        "1280": view_context.asset_url("static-banner/southbank-1280.jpg"),
        "1920": view_context.asset_url("static-banner/southbank-1920.jpg"),
        "2560": view_context.asset_url("static-banner/southbank-2560.jpg"),
      },
      "size"=> 'none'
    }
  end

private

  def latest_sermon
    @latest_sermon ||= Resource.resource_type('recording').
                       order('display_date DESC NULLS LAST').
                       first
  end

end
