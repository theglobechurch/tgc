require 'test_helper'

class Admin::ApiControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in FactoryBot.create(:admin)
  end

  test "resources without query returns null" do
    get :resource

    assert_response(:success)
    assert_equal('', response.body)
  end

  test "resource search should not respond with a query less than two chars" do
    create(:resource,
           :recording,
           :published,
           title: 'The post',
           display_date: '2017-09-10')

    get :resource, params: {q: 'th'}

    assert_response(:success)
    assert_equal('', response.body)
  end

  test "resource search should respond with a query more than two chars" do
    create(:resource,
           :recording,
           :published,
           title: 'The post',
           display_date: '2017-09-10')

    get :resource, params: {q: 'the'}

    assert_response(:success)
    body = JSON.parse(response.body)
    assert_equal('The post', body.first['title'])
  end

  test "resource search should search" do
    create(:resource,
           :recording,
           :published,
           title: 'present',
           display_date: '2017-09-10')
    create(:resource,
           :recording,
           :published,
           title: 'not there at all',
           display_date: '2017-09-10')

    get :resource, params: {q: 'present'}

    assert_response(:success)
    body = JSON.parse(response.body)
    assert_equal(1, body.count)
    assert_equal('present', body.first['title'])
  end
end
