# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(
#   name: 'Pochatok',
#   username: 'quietpochatok',
#   email: 'quiet_pochatok@gmail.com',
#   password: '123456'
# )

10.times do
  user = User.create!(
    name: FFaker::Name.unique.name,
    username: FFaker::Name.unique.last_name,
    email: FFaker::Internet.unique.email,
    password: '123456'
  )

  user.questions.create!(
    text: FFaker::Lorem.phrase
  )
end
