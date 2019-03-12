# rubocop:disable Metrics/BlockLength
FactoryBot.define do
  factory :resource do
    title { "Philemon: For Love's Sake" }
    introduction { "In the book of Philemon, Paul writes to a local…" }
    resource_type { %w[recording link blog download].sample }
    display_date { "2017-07-02 00:00:00" }
    bible_reference_json { '{"reference_book": "Philemon","reference_book_end_v": "1","reference_book_end_ch": "1","reference_book_start_v": "1","reference_book_start_ch": "1"}' }

    sequence :slug do |n|
      "philemon-for-loves-sake-#{n}"
    end

    trait :published do
      state { :published }
    end

    trait :draft do
      state { :draft }
    end

    trait :recording do
      resource_type { 'recording' }
      groupings {
        [Grouping.where(title: 'Sermon Series').take ||
          create(:grouping, :preaching, title: 'Sermon Series')]
      }
    end

    trait :one21 do
      resource_type { 'one21' }
      body { Rails.root.join('test', 'fixtures', 'files', 'one21.json').read }
      association :resource_parent,
                  :published,
                  :with_graphic,
                  factory: :resource
    end

    trait :with_graphic do
      association :graphic
    end

    trait :blog do
      resource_type { 'blog' }
    end

    trait :with_author do
      person
    end

    trait :link do
      resource_type { 'link' }
    end

  end
end
