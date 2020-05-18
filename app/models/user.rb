class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable, :omniauthable
  mount_uploader :image, ImageUploader
  
  has_many :posts, dependent: :destroy
  validates :user_name, presence: true, length: { maximum: 50 }
end
