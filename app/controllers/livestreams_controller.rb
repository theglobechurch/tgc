class LivestreamsController < ApplicationController
  def index
    youtubeId = '3AUGRNks8d4'
    @banner = {
      'title' => 'Live Stream',
      'size' => 'video',
      'description' => 'Church is about gathering together as God’s people. We think that is a precious and wonderful thing. There are occasions when gathering is not possible and at those times a livestream can help us until we can gather again…',
      'video' => "https://www.youtube.com/embed/#{youtubeId}",
      'hide-text' => true,
      'socialImg' => '/assets/live-og.jpg',
    }

  end
end
