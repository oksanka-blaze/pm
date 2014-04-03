# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name { Faker::Lorem.characters(rand(4..30)) }
    association :owner, factory: :user
    
    factory :invalid_project do
      name nil
    end
  end
end
