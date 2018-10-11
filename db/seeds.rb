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
gambino = User.create(email:'gambino@example.com',password:'america', password_confirmation: 'america')
Profile.create(user_id: user1.id, username: 'testuser2', food_types: 'landfish', bio: "I'm also not real...", image: "http://i.ebayimg.com/images/i/111130995742-0-1/s-l1000.jpg", following: "")
Profile.create(user_id: gambino.id, username: 'Childish Gambino', food_types: 'burgers, sushi, fries', bio: "Make fire erry day", image: "https://firebasestorage.googleapis.com/v0/b/youtencil-a36fd.appspot.com/o/profile-images%2Fdonald%20glover%20.jpg?alt=media&token=864cdeb4-6dbd-4005-ad32-df58ffb9faaf", following: "")
Tip.create(user_id: user1.id, restaurant: "Ralph's", food_types: 'various', description: "The pizza is dank and doesn't taste burnt", image: "http://i.ebayimg.com/images/i/111130995742-0-1/s-l1000.jpg")
