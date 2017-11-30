require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  test "Resource type scope" do
    create_list(:resource, 3, :published, :recording)
    create_list(:resource, 2, :published, :link)

    a = Resource.recording
    assert_equal(3, a.length)

    b = Resource.link
    assert_equal(2, b.length)
  end

  test "Resource should not save without a type" do
    r = Resource.new
    r.title = 'test'
    assert_not r.valid?
    assert_equal %i[resource_type], r.errors.keys
  end
end
