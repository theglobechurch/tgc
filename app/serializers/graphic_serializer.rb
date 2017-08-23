class GraphicSerializer < ActiveModel::Serializer
  attributes :id, :images

  def images
    {
      'thumbnail': object.background_image_thumbnail.try(:remote_url),
      '320': object.background_image_320.try(:remote_url),
      '640': object.background_image_640.try(:remote_url),
      '960': object.background_image_960.try(:remote_url),
      '1280': object.background_image_1280.try(:remote_url),
      '1920': object.background_image_1920.try(:remote_url),
      '2560': object.background_image_2560.try(:remote_url),
    }
  end
end
