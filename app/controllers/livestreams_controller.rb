class LivestreamsController < ApplicationController
  def index
    youtubeId = 'UVNRmfV4GXs'
    @banner = {
      'title' => 'Live Stream',
      'size' => 'video',
      'video' => "https://www.youtube.com/embed/#{youtubeId}",
      'hide-text' => true,
    }
  end
end
