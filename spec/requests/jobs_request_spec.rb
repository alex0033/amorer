require 'rails_helper'

RSpec.describe "Jobs", type: :request do
  let(:job_built) { build(:job) }
  let(:valid_params) do
    {
      job: {
        title: job_built.title,
        reward_type: job_built.reward_type,
        reward_min_amount: job_built.reward_min_amount,
        reward_max_amount: job_built.reward_max_amount,
        explanation: job_built.explanation,
      },
    }
  end
  let(:invalid_params) do
    {
      job: {
        title: job_built.title,
        reward_type: nil,
        reward_min_amount: job_built.reward_min_amount,
        reward_max_amount: job_built.reward_max_amount,
        explanation: job_built.explanation,
      },
    }
  end

  describe "created_data needed(#index #show #edit #destroy)" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:job) { create(:job, user: user) }
    let!(:other_job) { create(:job, user: other_user) }

    describe "#index" do
      context "when keyword is nil" do
        before do
          get jobs_path
        end

        it { expect(response.status).to eq(200) }
        it { expect(response.body).to include(job.title) }
        it { expect(response.body).to include(other_job.title) }
      end

      context "when keyword is job.title" do
        before do
          get jobs_path, params: { q: { title_or_explanation_cont: job.title } }
        end

        it { expect(response.status).to eq(200) }
        it { expect(response.body).to include(job.title) }
        it { expect(response.body).not_to include(other_job.title) }
      end

      context "when reward is 1200yen ~ 1400yen" do
        before do
          get jobs_path, params: {
            q: {
              reward_type: 1,
              reward_min_amount_gteq: 1000,
              reward_max_amount_lteq: 2100,
            },
          }
        end

        it { expect(response.status).to eq(200) }
        it { expect(response.body).to include(job.title) }
        it { expect(response.body).to include(other_job.title) }
      end

      context "when reward is 1800yen ~ 2000yen" do
        before do
          get jobs_path, params: {
            q: {
              reward_type: 1,
              reward_min_amount_gteq: 1300,
              reward_max_amount_lteq: 1500,
            },
          }
        end

        it { expect(response.status).to eq(200) }
        it { expect(response.body).not_to include(job.title) }
        it { expect(response.body).not_to include(other_job.title) }
      end
    end

    describe "#show" do
      before do
        get job_path(job)
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to include(job.title) }
      it { expect(response.body).not_to include(other_job.title) }
    end

    describe "#edit" do
      context "when correct_user" do
        before do
          sign_in user
          get edit_job_path(job)
        end

        it { expect(response.status).to eq(200) }
        it { expect(response.body).to include("求人編集") }
      end

      context "when not correct_user" do
        before do
          sign_in user
          get edit_job_path(other_job)
        end

        it_behaves_like "filter not_correct_user without Ajax"
      end

      context "when not signed_in" do
        before do
          get edit_job_path(job)
        end

        it_behaves_like "filter not_signed_in_user without Ajax"
      end
    end

    describe "#update" do
      context "when correct_user" do
        context "when valid_params" do
          before do
            sign_in user
            put job_path(job), params: valid_params
          end

          it { expect(response.status).to eq(302) }
          it { expect(response).to redirect_to job_path(job.id) }
          it { expect(Job.find_by(title: job_built.title)).to be_truthy }
        end

        context "when invalid_params" do
          before do
            sign_in user
            put job_path(job), params: invalid_params
          end

          it { expect(response.status).to eq(200) }
          it { expect(response.body).to include("求人編集") }
          it { expect(Job.find_by(title: job_built.title)).to be_falsy }
        end
      end

      context "when not correct_user" do
        before do
          sign_in user
          put job_path(other_job), params: valid_params
        end

        it_behaves_like "filter not_correct_user without Ajax"
        it { expect(Job.find_by(title: job_built.title)).to be_falsy }
      end

      context "when not signed_in" do
        before do
          get edit_job_path(job)
        end

        it_behaves_like "filter not_signed_in_user without Ajax"
        it { expect(Job.find_by(title: job_built.title)).to be_falsy }
      end
    end

    describe "#destroy" do
      context "when correct_user" do
        before do
          sign_in user
          delete job_path(job)
        end

        it { expect(response.status).to eq(302) }
        it { expect(response).to redirect_to root_path }
        it { expect(Job.find_by(title: job.title)).to be_falsy }
      end

      context "when not correct_user" do
        before do
          sign_in user
          delete job_path(other_job)
        end

        it_behaves_like "filter not_correct_user without Ajax"
        it { expect(Job.find_by(title: job.title)).to be_truthy }
      end

      context "when not signed_in" do
        before do
          delete job_path(job)
        end

        it_behaves_like "filter not_signed_in_user without Ajax"
        it { expect(Job.find_by(title: job.title)).to be_truthy }
      end
    end
  end

  describe "#new" do
    context "when signed_in" do
      let!(:user) { create(:user) }

      before do
        sign_in user
        get new_job_path
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to include("求人作成") }
    end

    context "when not signed_in" do
      before do
        get new_job_path
      end

      it_behaves_like "filter not_signed_in_user without Ajax"
    end
  end

  describe "#create" do
    let!(:user) { create(:user) }

    context "when signed_in" do
      context "when data is valid" do
        before do
          sign_in user
          post jobs_path, params: valid_params
        end

        it { expect(response.status).to eq(302) }
        it { expect(response).to redirect_to job_path(Job.last) }
        it { expect(Job.find_by(title: job_built.title)).to be_truthy }
      end

      context "when data is invalid" do
        before do
          sign_in user
          post jobs_path, params: invalid_params
        end

        it { expect(response.status).to eq(200) }
        it { expect(response.body).to include("求人作成") }
        it { expect(Job.find_by(title: job_built.title)).to be_falsy }
      end
    end

    context "when not signed_in" do
      before do
        post jobs_path, params: valid_params
      end

      it_behaves_like "filter not_signed_in_user without Ajax"
      it { expect(Job.find_by(title: job_built.title)).to be_falsy }
    end
  end
end
