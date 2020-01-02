class Image < ApplicationRecord
  belongs_to :tweet
  mount_uploader :image, TweetUploader, only: [:create]

  validates :image, presence: true
end
