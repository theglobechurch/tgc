# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(email: 'james@globe.church', password: 'password');

t1 = Team.create(name: 'Eldership')
t2 = Team.create(name: 'Leadership Team')

p = Person.create(first_name: "Jonty",
                  last_name: "Allcock",
                  display_name: "Jonty Allcock",
                  job_title: "Pastor",
                  biography_short: "Jonty is one of the pastors at The Globe Church")

PeopleTeam.create(person: p, team_id: t1)
PeopleTeam.create(person: p, team_id: t2)

gra = Graphic.create(
  background_image: ActionDispatch::Http::UploadedFile.new(
    tempfile: File.new(Rails.root.join('test',
                                      'fixtures',
                                      'files',
                                      'southwark.jpg')),
    filename: 'testupload.jpg'
  )
)

gt = GroupingType.create(title: "Preaching")
GroupingType.create(title: "Focus")
GroupingType.create(title: "Resources")
GroupingType.create(title: "Misc")

gro = Grouping.create(title: "Philemon: For Love's Sake",
                      description: "In the book of Philemon, Paul writes to a local church leader calling him to gospel love. In this series we’re going to see that gospel love will push us further and deeper than we could ever imagine.",
                      state: "published",
                      grouping_types: [gt],
                      group_type: 'series', # migrate away later
                      slug: "philemon-for-loves-sake",
                      graphic: gra)

Resource.create(title: "For the joy",
                state: "published",
                resource_type: "link",
                external_reference: "http://www.desiringgod.org/labs/for-the-joy-set-before-him",
                introduction: "The New Testament motivates us toward spiritual gr...",
                slug: "for-the-joy",
                person: p,
                groupings: [gro])


