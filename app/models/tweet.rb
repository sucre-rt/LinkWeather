class Tweet < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images

  validates :images, length: { minimum: 0, maximum: 6 }
  validates :text, presence: true

  scope :search, -> (area, date) do
    return if area.blank?
    tweet_like(area).tweet_date(date)
  end

  scope :tweet_like, -> (area) { where('text LIKE ?', "%#{area}%").order("created_at DESC") if area.present? }
  scope :tweet_date, -> (today) { where('created_at >= ?', today).order("created_at DESC") if today.present? }
end
