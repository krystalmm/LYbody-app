class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :instructor

  validates :user_id,presence: true, uniqueness: { message: "お客様はすでにご予約済みです。ご予約日時はマイページよりご確認頂けます。" }
  validates :start_time, presence: true, uniqueness: { message: "この時間はすでにご予約がございます。別の日時を選択してください。" }
  validates :end_time, presence: true
  validate :check_start_and_end_time, on: :create
  validate :check_start_time

  LESSON_HOUR = 1

  def check_start_and_end_time
    if self.start_time > self.end_time
      errors.add(:end_time)
    end
  end

  def check_start_time
    if self.start_time < Time.now
      errors.add(:start_time, "予約時間（開始時間）は現在の日時より遅い時間を選択してください。")
    end
  end

  def set_end_time
    self.end_time = self.start_time + LESSON_HOUR.hour
  end

  def date_and_time
    date = "#{start_time.year}年 #{start_time.month}月 #{start_time.day}日"
    start_time = "#{self.start_time.hour} : #{self.start_time.strftime('%M')}"
    end_time = "#{self.end_time.hour} : #{self.end_time.strftime('%M')}"
    "#{date}  #{start_time} ~ #{end_time}"
  end
end
