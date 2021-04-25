FactoryBot.define do
  factory :reservation do
    start_time { DateTime.current + 1.hour }
    end_time { DateTime.current + 2.hour }
    association :instructor
    association :user
  end
end
