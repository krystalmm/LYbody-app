FactoryBot.define do
  factory :instructor do
    name { 'Instructor' }
    sequence(:email) { |n| "instructor_#{n}@example.com" }
    password { 'password' }
    instructor_image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_instructor.png'), 'image/png') }
    has_lesson { true }
    comment { 'Instructor_comment' }
  end
end
