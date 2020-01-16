class Trust < ApplicationRecord
  belongs_to :valuer, class_name: 'User', foreign_key: 'valuer_id'
  belongs_to :good_user, class_name: 'User', foreign_key: 'good_user_id'

  validates :valuer, presence: true
  validates :good_user, presence: true
  validates :valuer, uniqueness: { scope: :good_user }
  validate :not_same_user

  def not_same_user
    if valuer == good_user
      errors.add(:valuer, "自分自身は評価できません")
    end
  end

end
