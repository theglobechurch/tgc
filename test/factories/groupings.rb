# rubocop:disable Metrics/LineLength
FactoryBot.define do
  factory :grouping do
    title "For Love's Sake"
    description "In the book of Philemon, Paul writes to a local church "\
      "leader calling him to gospel love. In this series we’re going to see "\
      "that gospel love will push us further and deeper than we could "\
      "ever imagine."
    start_date "2017-07-02 00:00:00"
    end_date "2017-08-27 00:00:00"

    sequence :grouping_types do |n|
      [create(:grouping_type, title: "Generic Grouping #{n}")]
    end

    group_type "series" # to be migrated away

    sequence :slug do |n|
      "for-loves-sake-#{n}"
    end

    trait :published do
      state :published
    end

    trait :draft do
      state :draft
    end

    trait :preaching do
      grouping_types {
        [GroupingType.where(title: 'Preaching').take || create(:grouping_type, title: 'Preaching')]
      }
    end

    trait :focus do
      grouping_types {
        [GroupingType.where(title: 'Focus').take || create(:grouping_type, title: 'Focus')]
      }
    end

    trait :with_graphic do
      association :graphic
    end

  end
end
