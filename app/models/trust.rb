class Trust < ApplicationRecord
  belongs_to :valuer, class_name: 'User', foreign_key: 'valuer_id'
  belongs_to :good_user, class_name: 'User', foreign_key: 'good_user_id'
end
