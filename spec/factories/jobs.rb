FactoryBot.define do
  factory :job do
    title { "MyString" }
    pay { "MyString" }
    explanation { "MyText" }
    user { nil }
  end
end
