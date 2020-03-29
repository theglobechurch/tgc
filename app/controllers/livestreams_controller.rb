class LivestreamsController < ApplicationController
  def index
    @main_stream = main_stream
    @previous_streams = previous_streams

    @latest_sermon = latest_sermon.decorate if latest_sermon

    @banner = {
      'title' => 'Live Stream',
      'size' => 'video',
      'description' => 'Church is about gathering together as God’s people. We think that is a precious and wonderful thing. There are occasions when gathering is not possible and at those times a livestream can help us until we can gather again…',
      'video' => "https://www.youtube.com/embed/#{@main_stream.youtubeId}?modestbranding=1&rel=0",
      'hide-text' => true,
      'socialImg' => '/assets/live-og.jpg',
    }
  end

private

  def main_stream
    @main_stream ||= Livestream.next_stream(Time.now) || Livestream.last_stream()
  end

  def previous_streams
    @previous_streams ||= Livestream.all
                            .where("live_at <= ?", Time.now)
                            .order(:live_at)
  end

  def latest_sermon
    @latest_sermon ||= Resource.
                       joins(:groupings).
                       where('groupings.group_type': 'Preaching').
                       resource_type('recording').
                       order('display_date DESC NULLS LAST').
                       first
  end
end
