FactoryBot.define do
  factory :person do
    first_name %w[Tom Dick Harry].sample
    last_name %w[Smith Jones Davis].sample
    job_title %w[Plumber Pastor Preacher].sample
    page true

    factory :person_on_team do
      transient do
        team_name 'Staff'
      end
      after(:create) do |p, eval|
        t = create(:team, name: eval.team_name)
        p.team_ids = [t.id]
      end
    end
  end
end
