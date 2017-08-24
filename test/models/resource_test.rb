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
end
