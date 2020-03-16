class LivestreamsController < ApplicationController
  def index
    @stream_url = 'https://www.youtube.com/embed/wIWt0kTtp3U'
    @banner = {
      'title' => 'Live Stream',
      'size' => 'video',
      'video' => 'https://www.youtube.com/embed/wIWt0kTtp3U',
      'hide-text' => true,
    }
  end
end
