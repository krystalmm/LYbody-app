class Batch::ReservationDelete
  def self.reservation_delete
    Reservation.where('start_time <= ?', DateTime.current).destroy_all
    p "現在時刻を過ぎた予約は削除しました。"
  end
end