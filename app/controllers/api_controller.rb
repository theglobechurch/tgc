class ApiController < ApplicationController

  def one21
    @resources = Resource.one21.order(published_at: :asc)
    render json: @resources
  end

end
