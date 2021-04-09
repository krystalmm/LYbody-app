json.array! @reservations do |reservation|
  json.id reservation.id
  json.start reservation.start_time
  json.end reservation.end_time
end
