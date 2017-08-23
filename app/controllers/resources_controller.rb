class ResourcesController < ApplicationController

  def index
    @groups = Grouping.all.decorate
    @banner = {
      "title" => 'Preaching',
      "image" => {
        "320": view_context.asset_url("static-banner/southbank-320.jpg"),
        "640": view_context.asset_url("static-banner/southbank-640.jpg"),
        "960": view_context.asset_url("static-banner/southbank-960.jpg"),
        "1280": view_context.asset_url("static-banner/southbank-1280.jpg"),
        "1920": view_context.asset_url("static-banner/southbank-1920.jpg"),
        "2560": view_context.asset_url("static-banner/southbank-2560.jpg"),
      },
    }
  end

  def show
    @resource = resource.decorate
    @banner = @resource.banner
  end

private

  def resources
    @resources ||= Resource.all
  end

  def resource
    @resource ||= resources.slug_find(params[:id])
  end

end
