require 'rails_helper'

RSpec.describe Message, type: :model do
  context "when data is valid" do
    let(:message) { build(:message) }

    it { expect(message.valid?).to be true }
  end

  context "when title is blank" do
    let(:message) { build(:message, title: " ") }

    it { expect(message.valid?).to be false }
  end

  context "when title is too long" do
    let(:message) { build(:message, title: "a" * 31) }

    it { expect(message.valid?).to be false }
  end

  context "when receiver_id is nil" do
    let(:message) { build(:message, receiver_id: nil) }

    it { expect(message.valid?).to be false }
  end

  context "when receiver is nil" do
    let(:message) { build(:message, receiver: nil) }

    it { expect(message.valid?).to be false }
  end

  context "when sender_id is nil" do
    let(:message) { build(:message, sender_id: nil) }

    it { expect(message.valid?).to be false }
  end

  context "when sender is nil" do
    let(:message) { build(:message, sender: nil) }

    it { expect(message.valid?).to be false }
  end

  context "when read is nil" do
    let(:message) { build(:message, read: nil) }

    it { expect(message.valid?).to be false }
  end

  context "when content is too long" do
    let(:message) { build(:message, content: "a" * 2001) }

    it { expect(message.valid?).to be false }
  end
end
