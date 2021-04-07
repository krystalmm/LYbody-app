Instructor.seed do |s|
  s.id = 1
  s.name = "Jean"
  s.email = "jean@lybody.com"
  s.password = "jeanpassword"
  s.instructor_image = File.open("./app/assets/images/instructor1.png")
  s.comment = "楽しいworkoutを提供することを心がけています！ You can do it!"
end

Instructor.seed do |s|
  s.id = 2
  s.name = "Edwin"
  s.email = "edwin@lybody.com"
  s.password = "edwinpassword"
  s.instructor_image = File.open("./app/assets/images/instructor2.png")
  s.comment = "時に厳しく、時に楽しく、をモットーにレッスンを提供しています！"
end

Instructor.seed do |s|
  s.id = 3
  s.name = "Kevin"
  s.email = "kevin@lybody.com"
  s.password = "kevinpassword"
end