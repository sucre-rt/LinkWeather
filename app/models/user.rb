class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: 'は有効なものを入力してください' }

  mount_uploader :image, ImageUploader
  has_many :tweets
  has_many :sub_areas
  has_many :valuers, class_name: 'Trust', foreign_key: 'valuer_id'
  has_many :good_users, class_name: 'Trust', foreign_key: 'good_user_id'

  def already_area?(area)
    self.sub_areas.exists?(area: area)
  end

end
