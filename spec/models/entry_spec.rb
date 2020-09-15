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

  context "when duplicated" do
    let(:entry) { build(:entry, user: user, job: job) }
    let!(:duplicated_entry) { create(:entry, user: user, job: job) }
    let(:user) { create(:user) }
    let(:job) { create(:job) }

    it { expect(entry.valid?).to be_falsy }
  end
end
