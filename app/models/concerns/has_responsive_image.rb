module HasResponsiveImage
  extend ActiveSupport::Concern
  extend Dragonfly::Model::Validations

  SIZES = [320, 640, 960, 1280, 1920, 2560].freeze

  included do
    delegate :available_responsive_image_sizes, to: :class
    class_attribute :responsive_image_attrs
    self.responsive_image_attrs = Set.new
  end

  class_methods do
    def responsive_image(key, validate_size: false)
      validates_property :format, of: key, in: %w[jpeg jpg png]

      if validate_size
        validates_property :width, of: key, in: (SIZES.last..Float::INFINITY)
      end

      dragonfly_accessor key do
        copy_to(:"#{key}_thumbnail") { |a| a.thumb('200x200#') }
        copy_to(:"#{key}_thumbnail_2x") { |a| a.thumb('400x400#') }

        SIZES.each do |size|
          copy_to(:"#{key}_#{size}") do |a|
            a.encode('jpg', "-quality 70 -interlace plane -resize #{size}x")
          end
        end
      end

      dragonfly_accessor :"#{key}_thumbnail"
      dragonfly_accessor :"#{key}_thumbnail_2x"

      SIZES.each do |size|
        dragonfly_accessor :"#{key}_#{size}"
      end

      responsive_image_attrs << key
    end
  end

  def responsive_image_size_url(key, size)
    public_send(:"#{key}_#{size}").try(:remote_url)
  end

  def responsive_image_size_urls(key)
    SIZES.
      map { |s| [:"#{s}", responsive_image_size_url(key, s)] }.
      to_h.
      delete_if { |_, v| v.blank? }
  end

end
