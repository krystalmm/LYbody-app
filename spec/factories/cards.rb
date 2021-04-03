FactoryBot.define do
  factory :card do
    sequence(:customer_id) { |n| "customer_#{n}" }
    sequence(:card_id) { |n| "card_#{n}" }
    association :user
  end
end
