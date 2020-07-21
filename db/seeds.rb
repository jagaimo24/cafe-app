User.create!(user_name: "test",
        email: "foobar@example.com",
        password:              "password",
        password_confirmation: "password")

49.times do |n|
  user_name  = Faker::Name.name
  email = "example-#{n+1}@rails.com"
  password = "password"
  User.create!(user_name:  user_name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(5)
5.times do
  shop_name  = Faker::Games::Pokemon.name
  address = Faker::Address.street_address
  phone_number = Faker::PhoneNumber.phone_number
  open_time = Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :day)
  end_time = Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :day)
  review = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.posts.create!(shop_name: shop_name, review: review, address: address, phone_number: phone_number, open_time: open_time, end_time: end_time, user_id: user.id) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }