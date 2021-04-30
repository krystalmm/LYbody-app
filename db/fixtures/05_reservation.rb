# Reservation.seed do |s|
#   s.id = 1
#   s.user = User.find(1)
#   s.instructor = Instructor.find(1)
#   s.start_time = Time.local(Time.current.year, Time.current.month, Time.current.day + 2, 17, 00)
#   s.end_time = Time.local(Time.current.year, Time.current.month, Time.current.day + 2, 18, 00)
# end

Reservation.seed do |s|
  s.id = 2
  s.user = User.find(4)
  s.instructor = Instructor.find(1)
  s.start_time = Time.local(Time.current.year, Time.current.month, Time.current.day + 1, 17, 00)
  s.end_time = Time.local(Time.current.year, Time.current.month, Time.current.day + 1, 18, 00)
end

# Reservation.seed do |s|
#   s.id = 3
#   s.user = User.find(5)
#   s.instructor = Instructor.find(2)
#   s.start_time = Time.local(Time.current.year, Time.current.month, Time.current.day + 2, 17, 00)
#   s.end_time = Time.local(Time.current.year, Time.current.month, Time.current.day + 2, 18, 00)
# end

# Reservation.seed do |s|
#   s.id = 4
#   s.user = User.find(3)
#   s.instructor = Instructor.find(3)
#   s.start_time = Time.local(Time.current.year, Time.current.month, Time.current.day + 2, 17, 00)
#   s.end_time = Time.local(Time.current.year, Time.current.month, Time.current.day + 2, 18, 00)
# end

Reservation.seed do |s|
  s.id = 5
  s.user = User.find(6)
  s.instructor = Instructor.find(4)
  s.start_time = Time.local(Time.current.year, Time.current.month, Time.current.day + 1, 17, 00)
  s.end_time = Time.local(Time.current.year, Time.current.month, Time.current.day + 1, 18, 00)
end
