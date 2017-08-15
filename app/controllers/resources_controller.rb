class ResourcesController < ApplicationController

  def index
    @resources = resources
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

