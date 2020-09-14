FactoryBot.define do
  factory :job do
    sequence(:title) { |n| "title_sample#{n}" }
    pay { "1000yen" }
    explanation { "It is very good." }
    user { create(:user) }
  end
end
