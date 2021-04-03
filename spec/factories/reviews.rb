FactoryBot.define do
  factory :review do
    instructor { nil }
    user { nil }
    comment { 'MyText' }
  end
end
