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

  test "Grouping should sort by date" do
    create(:grouping,
           :published,
           title: 'Second',
           start_date: '2017-01-01')

    create(:grouping,
           :published,
           start_date: nil,
           title: 'Last')

    create(:grouping,
           :published,
           title: 'First',
           start_date: '2017-06-01')

    g = Grouping.all
    assert_equal('First', g.first.title)
    assert_equal('Second', g.second.title)
    assert_equal('Last', g.third.title, 'Null dates should sort to the end')
  end
end
