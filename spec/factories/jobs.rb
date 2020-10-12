FactoryBot.define do
  factory :job do
    sequence(:title) { |n| "title_sample#{n}" }
    reward_type { 1 }
    reward_min_amount { 1000 }
    reward_max_amount { 2000 }
    explanation { "It is very good." }
    user { create(:user) }
  end
end
