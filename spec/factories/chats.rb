FactoryBot.define do
  factory :chat do
    is_user { false }
    message { 'Instructor Chats' }
    association :room

    trait :user_chat do
      is_user { true }
      message { 'User Chats' }
    end
  end
end
