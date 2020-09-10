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
end
