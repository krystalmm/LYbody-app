FactoryBot.define do
  factory :reservation do
    start_time { '2021-04-03 19:00:00' }
    end_time { '2021-04-03 20:00:00' }
    association :instructor
    association :user
  end
end
