class Tweet < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images

  scope :search, -> (area, date) do
    return if area.blank?
    tweet_like(area).tweet_date(date)
  end

  scope :tweet_like, -> (tweet) { where('text LIKE ?', "%#{tweet}%") if tweet.present? }
  scope :tweet_date, -> (today) { where('created_at >= ?', today) if today.present? }
end
