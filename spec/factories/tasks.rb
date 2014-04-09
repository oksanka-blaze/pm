# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    association :assignee, factory: :user
    association :project
    due_date { 2.hours.from_now }
    name { Faker::Lorem.words(3) }
    description { Faker::Lorem.paragraph }
  end
end
