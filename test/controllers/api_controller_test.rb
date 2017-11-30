require 'test_helper'

class ApiControllerTest < ActionController::TestCase

  test "one21" do
    create(:resource,
           :one21,
           :published)
    get :one21
    assert_response(:success)
    body = JSON.parse(response.body)
    assert_equal(1, body.count)
    assert_equal(4, body[0]['questions'].count)
    assert_equal(3, body[0]['questions'].count { |q| q['type'] == 'question' })
    assert_equal(1, body[0]['questions'].count { |q| q['type'] == 'pause' })
  end

end
