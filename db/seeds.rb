# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
100.times do
    User.create(
        {
            name: Faker::Movies::HarryPotter.character,
            avatar_url: Faker::Avatar.image,
            email: Faker::Internet.email,
            password: 'pass154063' 
        }
    )
end

150.times do
    user = rand(1..100)
    Tweet.create(
        {
            content: Faker::Movies::HarryPotter.quote, 
            user_id: user
        }
    )
end
AdminUser.create!(email: 'gato@example.com', password: 'nyapass', password_confirmation: 'nyapass') if Rails.env.development?