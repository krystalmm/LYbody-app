FactoryBot.define do
  factory :room do
    association :instructor
    association :user
  end
end
