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
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  validates :user_id, presence: true
  validates :shop_name, presence: true
  validates :review, presence: true
  mount_uploader :image, ImageUploader
  geocoded_by :address
  after_validation :geocode

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.where(post_id: id).
      where.not("user_id = ? or user_id = ?", current_user.id, user_id).select(:user_id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id)
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def create_notification_favorite!(current_user)
    temp = Notification.where([
      "visitor_id = ? and visited_id = ? and post_id = ? and action = ?",
      current_user.id, user_id, id, 'favorite',
    ])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked == true
      end
      notification.save if notification.valid?
    end
  end
end
