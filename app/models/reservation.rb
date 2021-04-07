class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :instructor

  def date_and_time
    date = I18n.l start_time, format: :long
    start_time = "#{self.start_time.hour} : #{self.start_time.min}"
    end_time = "#{self.end_time.hour} : #{self.end_time.min}"
    "#{date}  #{start_time} ~ #{end_time}"
  end
end
