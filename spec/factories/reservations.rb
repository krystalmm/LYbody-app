FactoryBot.define do
  factory :reservation do
    start_time { "#{DateTime.current.year}-#{DateTime.current.month + 1}-01 17:00" }
    end_time { "#{DateTime.current.year}-#{DateTime.current.month + 1}-01 18:00" }
    association :instructor
    association :user
  end
end