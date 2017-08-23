# /tests/integration/routes_test.rb
require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  test "route test" do
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
end
