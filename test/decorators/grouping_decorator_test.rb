require 'test_helper'

class GroupingDecoratorTest < Draper::TestCase

  setup do
    @grouping = create(:grouping, :published).decorate
  end

  test "date range - single year" do
    assert_equal(
      "July – August 2017",
      @grouping.date_range
    )
  end

  test "date range - spans years" do
    g = create(
      :grouping,
      :published,
      title: 'Test Group',
      slug: 'test-group',
      start_date: "2016-12-01",
      end_date: "2017-01-31"
    ).decorate

    assert_equal(
      "December 2016 – January 2017",
      g.date_range
    )
  end

end
