# == Schema Information
#
# Table name: posts
#
#  id                :bigint           not null, primary key
#  address           :string(255)
#  date              :string(255)
#  electrical_outlet :string(255)
#  end_time          :time
#  image             :string(255)
#  latitude          :float(24)
#  longitude         :float(24)
#  open_time         :time
#  phone_number      :string(255)
#  price             :string(255)
#  rating            :integer
#  review            :string(255)
#  shop_name         :string(255)      not null
#  smoking_seat      :string(255)
#  url               :string(255)
#  wifi              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
