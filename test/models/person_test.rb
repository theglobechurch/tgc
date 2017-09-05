require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "Person to string should be first name last name" do
    p = create(:person)
    assert_equal("#{p.first_name} #{p.last_name}", p.to_s)
  end

  test "Empty slug should generate off first name | last name" do
    p = create(:person,
               first_name: 'Joe',
               last_name: 'King')
    assert_equal("joe-king", p.slug)
  end

  test "Empty display name should generate off first name | last name" do
    p = create(:person,
               first_name: 'Joe',
               last_name: 'King')
    assert_equal("Joe King", p.display_name)
  end
end
