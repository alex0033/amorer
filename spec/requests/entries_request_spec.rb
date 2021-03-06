require 'rails_helper'

RSpec.describe "Entries", type: :request do
  let(:user) { create(:user) }
  let(:job) { create(:job) }

  describe "#create" do
    context "when not signed_in with Ajax" do
      before do
        post entries_path, params: { job_id: job.id }, xhr: true
      end

      it_behaves_like "filter not_signed_in_user with Ajax"
      it { expect(Entry.find_by(user: user, job: job)).to be_falsy }
    end

    context "when not signed_in without Ajax" do
      before do
        post entries_path, params: { job_id: job.id }
      end

      it_behaves_like "filter not_signed_in_user without Ajax"
      it { expect(Entry.find_by(user: user, job: job)).to be_falsy }
    end

    context "when signed_in with Ajax" do
      before do
        sign_in user
        post entries_path, params: { job_id: job.id }, xhr: true
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to include("応募中") }
      it { expect(Entry.find_by(user: user, job: job)).to be_truthy }
    end

    context "when signed_in without Ajax" do
      before do
        sign_in user
        post entries_path, params: { job_id: job.id }
      end

      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to job_path(job)  }
      it { expect(Entry.find_by(user: user, job: job)).to be_truthy }
    end
  end

  describe "#destroy" do
    let(:entry) { create(:entry, user: user, job: job) }

    context "when not signed_in with Ajax" do
      before do
        delete entry_path(entry), xhr: true
      end

      it_behaves_like "filter not_signed_in_user with Ajax"
      it { expect(Entry.find_by(id: entry.id)).to be_truthy }
    end

    context "when not signed_in without Ajax" do
      before do
        delete entry_path(entry)
      end

      it_behaves_like "filter not_signed_in_user without Ajax"
      it { expect(Entry.find_by(id: entry.id)).to be_truthy }
    end

    context "when not correct_user with Ajax" do
      let(:other_user) { create(:user) }

      before do
        sign_in other_user
        delete entry_path(entry), xhr: true
      end

      it_behaves_like "filter not_correct_user with Ajax"
      it { expect(Entry.find_by(id: entry.id)).to be_truthy }
    end

    context "when not correct_user without Ajax" do
      let(:other_user) { create(:user) }

      before do
        sign_in other_user
        delete entry_path(entry)
      end

      it_behaves_like "filter not_correct_user without Ajax"
      it { expect(Entry.find_by(id: entry.id)).to be_truthy }
    end

    context "when correct_user with Ajax" do
      before do
        sign_in user
        delete entry_path(entry), xhr: true
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to include("応募する") }
      it { expect(Entry.find_by(id: entry.id)).to be_falsy }
    end

    context "when correct_user without Ajax" do
      before do
        sign_in user
        delete entry_path(entry)
      end

      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to job_path(job.id) }
      it { expect(Entry.find_by(id: entry.id)).to be_falsy }
    end
  end
end
