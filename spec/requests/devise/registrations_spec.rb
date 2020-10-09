require 'rails_helper'

RSpec.describe "Devise/Registrations", type: :request do
  describe "#create" do
    let!(:user) { build(:user, password: password) }
    let(:password) { "password" }

    before do
      post user_registration_path, params: {
        user: {
          email: user.email,
          password: password,
          password_confirmation: password,
        },
      }
    end

    it { expect(response.status).to eq(302) }
    it { expect(response).to redirect_to user_path(User.last) }
  end

  describe "#update" do
    let!(:user) { create(:user) }
    let(:email_changed) { user.email + ".ch" }
    let(:after_name) { "after" }
    let(:after_self_introduction) { "after content" }

    before do
      sign_in user
      put user_registration_path, params: {
        user: {
          name: after_name,
          email: email_changed,
          self_introduction: after_self_introduction,
        },
      }
    end

    it { expect(response.status).to eq(302) }
    it { expect(response).to redirect_to user_path(user) }

    it "can update" do
      user_updated = User.find(user.id)
      expect(user_updated.name).to eq after_name
      expect(user_updated.email).to eq email_changed
      expect(user_updated.self_introduction).to eq after_self_introduction
    end
  end
end
