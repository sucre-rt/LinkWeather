require 'rails_helper'

RSpec.describe Trust, type: :model do
  before do
    @user = create(:user)
    @another_user = create(:email_user)
  end
  
  describe '#create' do
    it 'valuer_idとgood_user_idが違う値で、両方存在すれば保存できる' do
      trust = build(
        :trust, 
        valuer: @user, 
        good_user: @another_user
      )
      expect(trust).to be_valid
    end

    it 'valuer_idがなければ保存できない' do
      trust = build(
        :trust, 
        valuer: nil,
        good_user: @another_user
      )
      trust.valid?
      expect(trust.errors[:valuer]).to include("を入力してください")
    end

    it 'good_user_idがなければ保存できない' do
      trust = build(
        :trust,
        valuer: @user,
        good_user: nil
      )
      trust.valid?
      expect(trust.errors[:good_user]).to include("を入力してください")
    end

    it 'good_user_idとvaluer_idが同じ場合は保存できない' do
      trust = build(
        :trust,
        valuer: @user,
        good_user: @user
      )
      trust.valid?
      expect(trust.errors[:valuer]).to include("自分自身は評価できません")
    end

    it '同じ組み合わせのレコードは保存できない' do
      trust1 = create(
        :trust,
        valuer: @user,
        good_user: @another_user
      )
      trust2 = build(
        :trust,
        valuer: @user,
        good_user: @another_user
      )
      trust2.valid?
      expect(trust2.errors[:valuer]).to include("はすでに存在します")
    end

  end
end
