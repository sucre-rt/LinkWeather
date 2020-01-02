require 'rails_helper'

RSpec.describe SubArea, type: :model do
  
  describe '#create' do
    it 'areaがあると保存できる' do
      expect(build(:sub_area)).to be_valid
    end

    it 'areaがないと保存できない' do
      sub_area = build(:sub_area, area: nil)
      sub_area.valid?
      expect(sub_area.errors[:area]).to include("を入力してください")
    end

    it 'user_idがないと保存できない' do
      sub_area = build(:sub_area, user_id: nil)
      sub_area.valid?
      expect(sub_area.errors[:user]).to include("を入力してください")
    end
  end
end