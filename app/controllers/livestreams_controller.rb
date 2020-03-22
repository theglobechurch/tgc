class LivestreamsController < ApplicationController
  def index
    @main_stream = main_stream
    @previous_streams = previous_streams

    @banner = {
      'title' => 'Live Stream',
      'size' => 'video',
      'description' => 'Church is about gathering together as God’s people. We think that is a precious and wonderful thing. There are occasions when gathering is not possible and at those times a livestream can help us until we can gather again…',
      'video' => "https://www.youtube.com/embed/#{@main_stream.youtubeId}",
      'hide-text' => true,
      'socialImg' => '/assets/live-og.jpg',
    }
  end

private

  def main_stream
    @main_stream ||= Livestream.all
                       .where("live_at >= ?", Time.now - 8.hour)
                       .where("live_at <= ?", Time.now + 8.hour)
                       .first
  end

  def previous_streams
    @previous_streams ||= Livestream.all
                            .where("live_at <= ?", Time.now)
                            .order(:live_at)
  end
end
