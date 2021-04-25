FactoryBot.define do
  factory :instructor_lesson do
    association :instructor
    association :lesson
  end
end
