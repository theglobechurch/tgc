FactoryGirl.define do
  factory :resource do
    title "Philemon: For Love's Sake"
    introduction "In the book of Philemon, Paul writes to a local church "\
      "leader calling him to gospel love. In this series we’re going to see "\
      "that gospel love will push us further and deeper than we could "\
      "ever imagine."
    resource_type %w[recording link blog download].sample
    display_date "2017-07-02 00:00:00"

    sequence :slug do |n|
      "philemon-for-loves-sake-#{n}"
    end

    trait :published do
      state :published
    end

    trait :draft do
      state :draft
    end

    trait :recording do
      resource_type 'recording'
    end

    trait :link do
      resource_type 'link'
    end

  end
end
