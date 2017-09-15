require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase

  test "latest sermon should be on the preaching" do

    create(:resource,
           :recording,
           :published,
           title: 'latest sermon',
           display_date: '2017-09-10')

    create(:resource,
           :recording,
           :published,
           title: 'old sermon',
           display_date: '2016-01-10')

    create(:resource,
           :recording,
           :published,
           title: 'sermon with no date',
           display_date: nil)

    get :index

    assert_response(:success)
    assert_not_nil(assigns(:latest_sermon))
    assert_equal('latest sermon', assigns(:latest_sermon).title)
  end

end
