class ApiController < ApplicationController
  serialization_scope :view_context

  def one21
    @resources = Resource.joins(:resource_parent).
                 one21.
                 order('resource_parents_resources.display_date DESC')
    render json: @resources, each_serializer: One21Serializer
  end

end
