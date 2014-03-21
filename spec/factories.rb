FactoryGirl.define do

  factory :status do
    sequence(:content) { |n| "This is a status#{n}" }
    user
  end

  factory :user do
    sequence(:first_name) { |n| "Bob#{n}" }
    sequence(:last_name) { |n| "Smith#{n}" }
    sequence(:profile_name) { |n| "bobsmith#{n}" }
    sequence(:email) { |n| "Bob.Smith#{n}@example.com" }
  end
end