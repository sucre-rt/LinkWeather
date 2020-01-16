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
    
    it '同じ組み合わせのレコードは重複登録できない' do
      sub_area = create(:sub_area)
      sub_area_2 = build(:sub_area)
      sub_area_2.valid?
      expect(sub_area_2.errors[:area]).to include("はすでに存在します")
    end
  end
  
end