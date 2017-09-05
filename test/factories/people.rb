FactoryGirl.define do
  factory :person do
    first_name %w[Tom Dick Harry].sample
    last_name %w[Smith Jones Davis].sample
    job_title %w[Plumber Pastor Preacher]
  end
end
