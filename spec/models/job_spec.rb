require 'rails_helper'

RSpec.describe Job, type: :model do
  context "when data is valid" do
    let(:job) { build(:job) }

    it { expect(job.valid?).to be true }
  end

  context "when user is nil" do
    let(:job) { build(:job, user: nil) }

    it { expect(job.valid?).to be false }
  end

  context "when title is blank" do
    let(:job) { build(:job, title: " ") }

    it { expect(job.valid?).to be false }
  end

  context "when title is too long" do
    let(:job) { build(:job, title: "a" * 31) }

    it { expect(job.valid?).to be false }
  end

  context "when pay is too long" do
    let(:job) { build(:job, title: "a" * 31) }

    it { expect(job.valid?).to be false }
  end

  context "when reward_type is nil" do
    let(:job) { build(:job, reward_type: nil) }

    it { expect(job.valid?).to be false }
  end

  context "when explanation is blank" do
    let(:job) { build(:job, explanation: " ") }

    it { expect(job.valid?).to be false }
  end

  context "when explanation is too long" do
    let(:job) { build(:job, title: "a" * 2001) }

    it { expect(job.valid?).to be false }
  end
end
