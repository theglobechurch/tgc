class Image
  include ActiveModel::Model
  extend Dragonfly::Model
  extend Dragonfly::Model::Validations

  SIZES = [320, 640, 960, 1280, 1920, 2560].freeze

  attr_accessor :type
  attr_accessor :file_uid

  validates :file, presence: true
  validates_property :format, of: :file, in: %w[jpeg jpg png]

  dragonfly_accessor :file do
    SIZES.each do |size|
      copy_to(:"file_#{size}") do |a|
        if a.format == 'jpeg'
          a.encode('jpg', "-quality 70 -interlace plane -resize #{size}x")
        else
          a.encode(a.format, "-resize #{size}x")
        end
      end
    end
  end

  SIZES.each do |size|
    attr_accessor :"file_#{size}_uid"
    dragonfly_accessor :"file_#{size}"
  end

  def save
    save_dragonfly_attachments if valid?
  end

  def as_json(*)
    {
      file: {
        url: file.try(:remote_url),
        sources: SIZES.map do |s|
          [s, public_send(:"file_#{s}").try(:remote_url)]
        end.to_h,
      },
    }
  end
end
