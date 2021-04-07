Instructor.seed do |s|
  s.id = 1
  s.name = "Jean"
  s.email = "jean@lybody.com"
  s.password = "jeanpassword"
  s.instructor_image = File.open("./app/assets/images/instructor1.png")
  s.has_lesson = true
  s.comment = "楽しいworkoutを提供することを心がけています！ You can do it!"
end

Instructor.seed do |s|
  s.id = 2
  s.name = "Edwin"
  s.email = "edwin@lybody.com"
  s.password = "edwinpassword"
  s.instructor_image = File.open("./app/assets/images/instructor2.png")
  s.has_lesson = true
  s.comment = "時に厳しく、時に楽しく、をモットーにレッスンを提供しています！！"
end

Instructor.seed do |s|
  s.id = 3
  s.name = "Kevin"
  s.email = "kevin@lybody.com"
  s.password = "kevinpassword"
  s.instructor_image = File.open("./app/assets/images/instructor3.png")
  s.has_lesson = true
  s.comment = "運動することの楽しさを感じていただけると嬉しいです！一緒に頑張りましょう！"
end

Instructor.seed do |s|
  s.id = 4
  s.name = "Mary"
  s.email = "mary@lybody.com"
  s.password = "marypassword"
  s.instructor_image = File.open("./app/assets/images/instructor4.png")
  s.has_lesson = true
  s.comment = "理想の体を手に入れて自分に自信を持って欲しいです！Love your self!!"
end

Instructor.seed do |s|
  s.id = 5
  s.name = "Nancy"
  s.email = "nancy@lybody.com"
  s.password = "nancypassword"
  s.instructor_image = File.open("./app/assets/images/instructor5.png")
  s.has_lesson = true
  s.comment = "心身ともに強く美しくなっていただけるように全力でサポートします！！"
end

Instructor.seed do |s|
  s.id = 6
  s.name = "Jessica"
  s.email = "jessica@lybody.com"
  s.password = "jessicapassword"
  s.instructor_image = File.open("./app/assets/images/instructor6.png")
  s.has_lesson = false
  s.comment = "私のレッスンで楽しく笑顔になっていただけたら嬉しいです！！"
end
