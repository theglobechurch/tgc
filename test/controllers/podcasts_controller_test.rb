require 'test_helper'

class PodcastsControllerTest < ActionController::TestCase

  test "Index request should redirect to preaching" do
    get :index
    assert_response(:redirect)
    assert_redirected_to preaching_path
  end

end
