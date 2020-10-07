require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "#show" do
    let!(:user) { create(:user, name: "name") }

    context "when user not signed_in" do
      before do
        get user_path(user)
      end

      it_behaves_like "filter not_signed_in_user without Ajax"
    end

    context "when user signed_in" do
      let!(:other_user) { create(:user, name: "other_name") }

      context "when user tries to uncorrect path" do
        before do
          sign_in user
          get user_path(user.id + other_user.id)
        end

        it { expect(response.status).to eq(302) }
        it { expect(response).to redirect_to root_path }
      end

      context "when user tries to correct path" do
        before do
          sign_in user
          get user_path(other_user)
        end

        it { expect(response.status).to eq(200) }
        it { expect(response.body).to include(other_user.name) }
      end
    end
  end
end
