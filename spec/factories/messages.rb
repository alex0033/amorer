FactoryBot.define do
  factory :message do
    sequence(:title) { |n| "Message#{n}" }
    receiver { create(:user) }
    sender { create(:user) }
    read { false }
    kind { 0 }
    content { "MyText" }
  end
end
