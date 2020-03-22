class Livestream < ApplicationRecord
  self.table_name = "livestreams"

  default_scope { order(live_at: :desc) }

  validates :youtubeId, :presence => true
  validates :live_at, :presence => true

  def to_s
    youtubeId
  end

  def self.next_stream(time)
    where("live_at >= ?", time - 8.hour)
    .first
  end

  def self.last_stream()
    order(live_at: :desc)
    .first
  end
end 
