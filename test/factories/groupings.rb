FactoryGirl.define do
  factory :grouping do
    title "Philemon: For Love's Sake"
    description "In the book of Philemon, Paul writes to a local church "\
      "leader calling him to gospel love. In this series we’re going to see "\
      "that gospel love will push us further and deeper than we could "\
      "ever imagine."
    group_type "series"
    start_date "2017-07-02 00:00:00"
    end_date "2017-08-27 00:00:00"
    slug "philemon-for-loves-sake"

    trait :published do
      state :published
    end

    trait :draft do
      state :draft
    end

  end
end
