class ApiController < ApplicationController
  serialization_scope :view_context
  before_action :set_headers

  def one21
    @resources = Resource.joins(:resource_parent).
                 one21.
                 order('resource_parents_resources.display_date DESC')
    render json: @resources, each_serializer: One21Serializer
  end

private

  def set_headers
    # Allow GET from anywhere
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'GET'
  end

end
