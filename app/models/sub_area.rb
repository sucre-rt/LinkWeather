class SubArea < ApplicationRecord
  belongs_to :user
  
  validates :area, presence: true
  validates :area, uniqueness: { scope: :user }
end
