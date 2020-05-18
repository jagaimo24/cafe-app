10.times do |n|
  user_name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(user_name:  user_name,
               email: email,
               password:              password,
               password_confirmation: password)
end
users = User.order(:created_at).take(5)
5.times do
  shop_name  = Faker::Games::Pokemon.name
  review = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.posts.create!(shop_name: shop_name, review: review, user_id: user.id) }
end