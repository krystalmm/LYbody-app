FactoryBot.define do
  factory :chat do
    room { nil }
    is_user { false }
    message { 'MyText' }
  end
end
