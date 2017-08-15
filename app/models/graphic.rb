class Graphic < ApplicationRecord

  include HasResponsiveImage

  default_scope { order(created_at: :desc) }

  responsive_image :background_image, validate_size: true

  def background_image_size_urls
    responsive_image_size_urls(:background_image)
  end

end
