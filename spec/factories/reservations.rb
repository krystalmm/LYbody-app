FactoryBot.define do
  factory :reservation do
    user_id { 1 }
    instructor_id { 1 }
    start_time { "2021-04-03 01:05:50" }
    end_time { "2021-04-03 01:05:50" }
  end
end
