class ResourcesController < ApplicationController

  def index
    @resources = resources
  end

  def show
    @resource = resource
  end

private

  def resources
    @resources ||= Resource.all
  end

  def resource
    @resource ||= resources.slug_find(params[:id])
  end

end

