FactoryBot.define do
  factory :entry do
    user { create(:user) }
    job { create(:job) }
  end
end
