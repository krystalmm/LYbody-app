FactoryBot.define do
  factory :review do
    comment { 'Review comment' }
    association :instructor
    association :user
  end
end
