require 'rails_helper'

RSpec.describe JobsHelper do
  describe "show_reward(job)" do
    subject { show_reward(job) }

    let(:type1) { "時給" }
    let(:type2) { "日給" }
    let(:type3) { "成果報酬" }

    def build_job(type: reward_type, min: min_amount, max: max_amount)
      build(
        :job,
        reward_type: type,
        reward_min_amount: min,
        reward_max_amount: max
      )
    end

    context "when reward_type is 1" do
      let(:reward_type) { 1 }
      let(:min_amount) { 1000 }
      let(:max_amount) { 1500 }

      context "when reward_min_amount:min_amount reward_max_amount:max_amount" do
        let(:job) { build_job }

        it { is_expected.to eq "#{type1}：#{min_amount}円〜#{max_amount}円" }
      end

      context "when reward_min_amount:nil reward_max_amount:max_amount" do
        let(:job) { build_job(min: nil) }

        it { is_expected.to eq "#{type1}：#{max_amount}円" }
      end

      context "when reward_min_amount:min_amount reward_max_amount:nil" do
        let(:job) { build_job(max: nil) }

        it { is_expected.to eq "#{type1}：#{min_amount}円" }
      end

      context "when reward_min_amount:nil reward_max_amount:nil" do
        let(:job) { build_job(min: nil, max: nil) }

        it { is_expected.to eq "#{type1}：#{REWARD_MESSAGE}" }
      end
    end

    context "when reward_type is 2" do
      let(:reward_type) { 2 }
      let(:min_amount) { 10000 }
      let(:max_amount) { 15000 }

      context "when reward_min_amount:min_amount reward_max_amount:max_amount" do
        let(:job) { build_job }

        it { is_expected.to eq "#{type2}：#{min_amount}円〜#{max_amount}円" }
      end

      context "when reward_min_amount:nil reward_max_amount:max_amount" do
        let(:job) { build_job(min: nil) }

        it { is_expected.to eq "#{type2}：#{max_amount}円" }
      end

      context "when reward_min_amount:min_amount reward_max_amount:nil" do
        let(:job) { build_job(max: nil) }

        it { is_expected.to eq "#{type2}：#{min_amount}円" }
      end

      context "when reward_min_amount:nil reward_max_amount:nil" do
        let(:job) { build_job(min: nil, max: nil) }

        it { is_expected.to eq "#{type2}：#{REWARD_MESSAGE}" }
      end
    end

    context "when reward_type is 2" do
      let(:reward_type) { 3 }
      let(:min_amount) { 10000 }
      let(:max_amount) { 15000 }

      context "when reward_min_amount:min_amount reward_max_amount:max_amount" do
        let(:job) { build_job }

        it { is_expected.to eq "#{type3}：#{min_amount}円〜#{max_amount}円" }
      end

      context "when reward_min_amount:nil reward_max_amount:max_amount" do
        let(:job) { build_job(min: nil) }

        it { is_expected.to eq "#{type3}：#{max_amount}円" }
      end

      context "when reward_min_amount:min_amount reward_max_amount:nil" do
        let(:job) { build_job(max: nil) }

        it { is_expected.to eq "#{type3}：#{min_amount}円" }
      end

      context "when reward_min_amount:nil reward_max_amount:nil" do
        let(:job) { build_job(min: nil, max: nil) }

        it { is_expected.to eq "#{type3}：#{REWARD_MESSAGE}" }
      end
    end

    context "when reward_type is 4" do
      let(:reward_type) { 4 }
      let(:min_amount) { 10000 }
      let(:max_amount) { 15000 }
      let(:job) { build_job(max: nil) }

      it { is_expected.to eq REWARD_MESSAGE }
    end
  end
end
