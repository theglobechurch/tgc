FactoryBot.define do
  factory :admin, class: 'User' do

    sequence :email do |n|
      "admin#{n}@example.com"
    end

    password "asdfasdfasdf"
    password_confirmation { password }
  end
end
