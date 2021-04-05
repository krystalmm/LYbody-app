# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Instructor.create!(
  name: "Jean",
  email: "jean@lybody.com",
  password: "jeanpassword",
  instructor_image: File.open("./app/assets/images/instructor1.png"),
  mind: "楽しいworkoutを提供することを心がけています",
  comment: "You can do it! 一緒に頑張りましょう!"
)