json.array!(@reservations) do |reservation|
  json.start reservation.start_time
  json.end reservation.end_time
  json.url reservation_url(reservation, format: :html)
end