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
  address = "東京都新宿区"
  phone_number = Faker::PhoneNumber.phone_number
  url = Faker::Internet.url
  open_time = Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :day)
  end_time = Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :day)
  wifi = rand(1..2)
  electrical_outlet = rand(1..2)
  rating = rand(1..5)+0.0
  review = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.posts.create!(shop_name: shop_name,
                                         review: review,
                                         address: address,
                                         phone_number: phone_number,
                                         open_time: open_time,
                                         end_time: end_time,
                                         url: url,
                                         wifi: wifi,
                                         electrical_outlet: electrical_outlet,
                                         rating: rating,
                                         user_id: user.id) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }