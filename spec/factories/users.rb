FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "sample#{n}" }
    sequence(:email) { |n| "sample#{n}@example.com" }
    password { "password" }

    factory :user_with_facebook do
      provider { "facebook" }
      sequence(:uid) { |n| "00000#{n}" }
    end
  end
end
