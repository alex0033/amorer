require 'rails_helper'

RSpec.describe Entry, type: :model do
  context "when data is valid" do
    let(:entry) { build(:entry) }

    it { expect(entry.valid?).to be true }
  end

  context "when user is nil" do
    let(:entry) { build(:entry, user: nil) }

    it { expect(entry.valid?).to be false }
  end

  context "when job is nil" do
    let(:entry) { build(:entry, job: nil) }

    it { expect(entry.valid?).to be false }
  end
end
