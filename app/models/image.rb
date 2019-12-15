class Image < ApplicationRecord
  belongs_to :tweet
  mount_uploader :image, TweetUploader
end
