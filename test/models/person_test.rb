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

  test "Should sort default last name, first name" do
    p1 = create(:person,
                first_name: 'Sam',
                last_name: 'Jones')
    p2 = create(:person,
                first_name: 'Adam',
                last_name: 'Jones')
    p3 = create(:person,
                first_name: 'Zach',
                last_name: 'Adams')
    all = Person.all
    assert_equal(p3.display_name, all[0].display_name)
    assert_equal(p2.display_name, all[1].display_name)
    assert_equal(p1.display_name, all[2].display_name)
  end

  test "Person on team" do
    create(:person_on_team,
           first_name: 'Joe',
           last_name: 'Smith',
           team_name: 'Fishing')
    create(:person_on_team,
           first_name: 'Sam',
           last_name: 'Jones',
           team_name: 'Fishing')
    create(:person_on_team,
           first_name: 'Peter',
           last_name: 'Jakeman',
           team_name: 'Farming')
    p = Person.team('Fishing')
    assert_equal(2, p.count)
    assert_equal('Sam Jones', p[0].display_name)
    assert_equal('Joe Smith', p[1].display_name)
  end
end
