class Upload < ApplicationRecord
  
  extend Dragonfly::Model::Validations

  # Might be useful for mp3 parsing later...
  # https://github.com/moumar/ruby-mp3info

  has_one :resource

  default_scope { order(created_at: :desc) }

  dragonfly_accessor :file
  
  before_validation do |r|
    r.filesize = r.file.size
    r.meta = {
      'mime_type': r.file.mime_type,
      'type': r.file.mime_type.match(/[^\/]*/)[0]
    }
  end

  validates :filesize, presence: true, numericality: { only_integer: true }
  validates_property :mime_type, of: :file, in: %w(
    audio/mp3
    audio/mpeg
  )

end
