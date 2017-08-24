require 'test_helper'

class GroupingTest < ActiveSupport::TestCase
  test "Group type scope" do
    create_list(:grouping, 3, :published, :series)
    create_list(:grouping, 2, :published, :resource)

    s = Grouping.series
    assert_equal(3, s.length)

    r = Grouping.resource
    assert_equal(2, r.length)
  end
end
