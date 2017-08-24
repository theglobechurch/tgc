class ResourcesController < ApplicationController
  layout 'application', only: ['preview']

  def index
    @groups = groups.decorate
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

  def series
    @group = group.decorate
    @banner = group.banner
    @recordings = @group.resources.recording.order(display_date: :asc)
    @banner['hide-text'] = true
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

  def groups
    @groups ||= Grouping.series
  end

  def group
    @group ||= groups.slug_find(params[:id])
  end

end
