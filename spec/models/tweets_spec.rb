require 'rails_helper'

RSpec.describe Tweet, type: :model do

  describe '#create' do
    it 'textがあれば保存できる' do
      expect(build(:tweet)).to be_valid
    end

    it 'textがないと保存できない' do
      tweet = build(:tweet, text: nil)
      tweet.valid?
      expect(tweet.errors[:text]).to include("を入力してください")
    end

    it "user_idがないと保存できない" do
      tweet = build(:tweet, user_id: nil)
      tweet.valid?
      expect(tweet.errors[:user]).to include("を入力してください")
    end
  end

end