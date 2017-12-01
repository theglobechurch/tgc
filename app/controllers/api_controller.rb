class ApiController < ApplicationController
  serialization_scope :view_context

  def one21
    @resources = Resource.one21.order(published_at: :asc)
    render json: @resources, each_serializer: One21Serializer
  end

end
