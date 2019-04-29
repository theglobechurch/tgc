class ResourcesController < ApplicationController
  layout 'application'

  def index
    img_location = 'static-banner/the-globe-church-preaching_'
    @groups = groups.decorate
    @banner = {
      "title" => 'Preaching',
      "image" => {
        "320": view_context.asset_path("#{img_location}320.jpg"),
        "640": view_context.asset_path("#{img_location}640.jpg"),
        "960": view_context.asset_path("#{img_location}960.jpg"),
        "1280": view_context.asset_path("#{img_location}1280.jpg"),
        "1920": view_context.asset_path("#{img_location}1920.jpg"),
        "2560": view_context.asset_path("#{img_location}2560.jpg"),
      },
    }
    @latest_sermon = latest_sermon.decorate if latest_sermon
  end

  def series
    @group = group.decorate
    @banner = group.banner
    @recordings = @group.resources.recording.order(display_date: :asc)
    @blogs = @group.resources.blog.order(display_date: :asc)
    @banner['hide-text'] = true
  end

  def blog
    img_location = 'static-banner/the-globe-church-blog_'
    @blogs = Resource.blog.order(display_date: :desc)
    @banner = {
      "title" => "Blog",
      "size" => "small",
      "image" => {
        "320": view_context.asset_path("#{img_location}320.jpg"),
        "640": view_context.asset_path("#{img_location}640.jpg"),
        "960": view_context.asset_path("#{img_location}960.jpg"),
        "1280": view_context.asset_path("#{img_location}1280.jpg"),
        "1920": view_context.asset_path("#{img_location}1920.jpg"),
        "2560": view_context.asset_path("#{img_location}2560.jpg"),
      },
    }
  end

  def show
    @resource = resource.decorate
    
    if @resource.resource_type == '121'
      raise ActionController::RoutingError, 'Not Found'
    end

    @banner = @resource.banner
  end

private

  def resources
    @resources ||= Resource.all
  end

  def resource
    @resource ||= resources.slug_find(params[:id])
  end

  def latest_sermon
    @latest_sermon ||= resources.
                       joins(:groupings).
                       where('groupings.group_type': 'Preaching').
                       resource_type('recording').
                       order('display_date DESC NULLS LAST').
                       first
  end

  def groups
    @groups ||= Grouping.all
  end

  def group
    @group ||= groups.slug_find(params[:id])
  end

end
