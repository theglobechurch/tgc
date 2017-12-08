# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(email: 'james@globe.church', password: 'password');

Resource.create(title: "For the joy",
                state: "published",
                resource_type: "link",
                external_reference: "http://www.desiringgod.org/labs/for-the-joy-set-before-him",
                introduction: "The New Testament motivates us toward spiritual gr...",
                slug: "for-the-joy")

Grouping.create(title: "Philemon: For Love's Sake",
                description: "In the book of Philemon, Paul writes to a local church leader calling him to gospel love. In this series we’re going to see that gospel love will push us further and deeper than we could ever imagine.",
                state: "published",
                group_type: "series",
                slug: "philemon-for-loves-sake")

People.create(first_name: "Jonty",
              last_name: "Allcock",
              display_name: "Jonty Allcock",
              job_title: "Pastor",
              biography_short: "Jonty is one of the pastors at The Globe Church")
