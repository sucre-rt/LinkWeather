class SubArea < ApplicationRecord
  belongs_to :user
  
  validates :area, presence: true
  validates :area, uniquness: { scope: :user }
end
