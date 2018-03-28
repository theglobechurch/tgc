class ApiController < ApplicationController
  before_action :set_headers

  def one21
    @resources = Resource.joins(:resource_parent).
                 one21.
                 order('resource_parents_resources.display_date DESC')
    
    data = {
      name: "The Globe Church",
      slug: "the-globe-church",
      url: "https://www.globe.church",
      image: "http://localhost:3000/images/globe-banner-960.jpg",
      studies: ActiveModel::SerializableResource.new(
        @resources,
        each_serializer: One21Serializer
      ).serializable_hash
    }

    render json: data
  end

private

  def set_headers
    # Allow GET from anywhere
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'GET'
  end

end
