require 'rails_helper'

RSpec.describe "OmniauthCallbacks", type: :request do
  describe "#facebook" do
    context "when user is created" do
      let(:user) { create(:user_with_facebook) }

      before do
        Rails.application.env_config['omniauth.auth'] = facebook_mock(user)
        get user_facebook_omniauth_callback_path
      end

      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to user_path(user) }
    end

    context "when user is not created" do
      let(:user) { build(:user_with_facebook) }

      before do
        Rails.application.env_config['omniauth.auth'] = facebook_mock(user)
        get user_facebook_omniauth_callback_path
      end

      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to user_path(User.find_by(email: user.email)) }
    end

    context "when facebook_mock is invalid" do
      let(:user) { build(:user_with_facebook) }

      before do
        Rails.application.env_config['omniauth.auth'] = facebook_invalid_mock(user)
        get user_facebook_omniauth_callback_path
      end

      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to new_user_registration_url }
    end
  end
end
