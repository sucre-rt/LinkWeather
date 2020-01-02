require 'rails_helper'

RSpec.describe Image, type: :model do
  describe '#create' do
    it "imageがあれば保存できる" do
      expect(build(:image)).to be_valid
    end

    it "imageがないと保存できない" do
      image = build(:image, image: nil)
      image.valid?
      expect(image.errors[:image]).to include("を入力してください")
    end

    it "tweet_idがないと保存できない" do
      image = build(:image, tweet_id: nil)
      image.valid?
      expect(image.errors[:tweet]).to include("を入力してください")
    end
  end
end