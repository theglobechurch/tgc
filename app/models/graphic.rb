class Graphic < ApplicationRecord

  include HasResponsiveImage

  default_scope { order(created_at: :desc) }

  responsive_image :background_image, validate_size: true

end
