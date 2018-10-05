# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.all.each {|user| user.destroy}
Profile.all.each {|profile| profile.destroy}
Tip.all.each {|tip| tip.destroy}

user1 = User.create(email:'youtensil@example.com',password:'food123', password_confirmation: 'food123')
Profile.create(user_id: user1.id, username: 'testuser2', food_types: 'landfish', bio: "I'm also not real...")
Tip.create(user_id: user1.id, restaurant: "Ralph's", food_types: 'various', description: "The pizza is dank and doesn't taste burnt")
