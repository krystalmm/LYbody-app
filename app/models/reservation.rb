class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :instructor

  LESSON_HOUR = 1

  def set_end_time
    self.end_time = self.start_time + LESSON_HOUR.hour
  end

  def date_and_time
    date = "#{start_time.year}年 #{start_time.month}月 #{start_time.day}日"
    start_time = "#{self.start_time.hour} : #{self.start_time.min}"
    end_time = "#{self.end_time.hour} : #{self.end_time.min}"
    "#{date}  #{start_time} ~ #{end_time}"
  end
end
