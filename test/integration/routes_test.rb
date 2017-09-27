# /tests/integration/routes_test.rb
require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  test "static pages have routes" do
    assert_generates(
      "/",
      controller: "homepages",
      action: "index",
    )

    assert_generates(
      "/about",
      controller: "pages",
      action: "show",
      id: "about",
    )

    assert_generates(
      "/about/jesus",
      controller: "pages",
      action: "show",
      id: "about/jesus",
    )

    assert_generates(
      "/when-and-where",
      controller: "pages",
      action: "show",
      id: "when-and-where",
    )

    assert_generates(
      "/contact",
      controller: "pages",
      action: "show",
      id: "contact",
    )

  end

  test "people should not have an index page" do
    assert_raises(ActionController::RoutingError) do
      get '/people'
    end
  end
end
