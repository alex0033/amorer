require 'rails_helper'

RSpec.describe User, type: :model do
  context "when data is valid" do
    let(:user) { build(:user) }

    it { expect(user.valid?).to be true }
  end

  context "when name is nil" do
    let(:user) { build(:user, name: nil) }

    it { expect(user.valid?).to be false }
  end

  context "when name is blank" do
    let(:user) { build(:user, name: " ") }

    it { expect(user.valid?).to be false }
  end

  context "when name is too long" do
    let(:user) { build(:user, name: "a" * 21) }

    it { expect(user.valid?).to be false }
  end

  context "when self_introduction is too long" do
    let(:user) { build(:user, self_introduction: "a" * 2001) }

    it { expect(user.valid?).to be false }
  end

  # 以下、画像関連のテスト
  context "when has valid type image" do
    let(:valid_image) { File.open('spec/factories/file_data/jpg_file.jpg') }

    context "without x, y and so on" do
      let(:user) { create(:user) }

      before do
        user.image.attach(io: valid_image, filename: 'jpg_file.jpg', content_type: 'image/jpg')
      end

      it { expect(user.valid?).to be false }
    end

    context "with x, y and so on" do
      let(:user) { create(:user, x: 0, y: 0, height: 20, width: 20) }

      before do
        user.image.attach(io: valid_image, filename: 'jpg_file.jpg', content_type: 'image/jpg')
      end

      it { expect(user.valid?).to be true }
    end

    context "when has valid type image" do
      let(:user) { create(:user, x: 0, y: 0, height: 20, width: 20) }
      let(:invalid_image) { File.open('spec/factories/file_data/text_file.txt') }

      before do
        user.image.attach(io: invalid_image, filename: 'text_file.txt', content_type: 'text/txt')
      end

      it { expect(user.valid?).to be false }
    end

    context "when has too big image" do
      let(:user) { create(:user, x: 0, y: 0, height: 20, width: 20) }
      let(:big_image) { File.open('spec/factories/file_data/big_file.jpg') }

      before do
        user.image.attach(io: big_image, filename: 'big_file.jpg', content_type: 'image/jpg')
      end

      it { expect(user.valid?).to be false }
    end
  end
end
