class Livestream < ApplicationRecord
  self.table_name = "livestreams"

  default_scope { order(live_at: :desc) }

  validates :youtubeId, :presence => true
  validates :live_at, :presence => true

  def to_s
    youtubeId
  end
end 
