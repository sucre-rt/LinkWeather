require 'rails_helper'

describe User do
  describe '#create' do
    it "nameがないと保存できない" do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "emailがないと保存できない" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "重複したメールアドレスでは登録できない" do
      user = create(:email_user)
      another_user = build(:email_user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "passowrdがないと保存できない" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "password_confirmationがないと保存できない" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "passwordが６文字以上あれば登録できる" do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user).to be_valid
    end

    it "passwordが５文字以下であれば登録できない" do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "name, email, password, password_confirmationがあれば保存できる" do
      user = build(:user)
      expect(user).to be_valid
    end

  end
end