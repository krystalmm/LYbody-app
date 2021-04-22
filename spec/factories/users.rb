FactoryBot.define do
  factory :user do
    firstname { 'Test' }
    lastname { 'User' }
    kana_firstname { 'テスト' }
    kana_lastname { 'ユーザー' }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { 'password' }
    phone_number { '08011112222' }
    sequence(:subscription_id) { |n| "sub_xxxxxxxxxxxx#{n}" }
    is_valid { true }
    is_payed { true }
    icon_image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_icon.png'), 'image/png') }

    trait :invalid_user do
      is_valid { false }
    end

    trait :unpayed_user do
      is_payed { false }
    end
  end
end
