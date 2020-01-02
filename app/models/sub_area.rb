class SubArea < ApplicationRecord
  belongs_to :user
  
  validates :area, presence: true
end
