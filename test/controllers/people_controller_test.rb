require 'test_helper'

class PeopleControllerTest < ActionController::TestCase

  test "invalid slug should 404" do
    get :show, params: {id: 'not-a-slug'}
    assert_response(:missing)
  end

  test "person without bio page should 404" do
    p = create(:person,
               page: false)

    get :show, params: {id: p.slug}
    assert_response(:missing)
  end

  test "person with bio page should display" do
    p = create(:person,
               page: true)

    get :show, params: {id: p.slug}
    assert_response(:success)
  end

end
