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
