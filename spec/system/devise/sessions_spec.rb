require 'rails_helper'

RSpec.describe "Devise/Sessions", type: :system do
  let!(:user) { create(:user, password: password) }
  let(:password) { "password" }

  it "make session" do
    visit root_path
    within(:css, '.header') do
      click_on "ログイン"
    end
    expect(page).to have_current_path new_user_session_path
    # 不正な入力
    within(:css, '.form-box') do
      fill_in('user_email', with: "invalid")
      fill_in('user_password', with: password)
      click_on "ログイン"
      expect(page).to have_content("ログイン")
    end
    # 正しい入力
    within(:css, '.form-box') do
      fill_in('user_email', with: user.email)
      fill_in('user_password', with: password)
      click_on "ログイン"
    end
    expect(page).to have_current_path root_path
  end

  it "delete session" do
    sign_in user
    visit edit_user_registration_path
    within(:css, '.form-box') do
      click_on "ログアウト"
    end
    expect(page).to have_current_path root_path
  end
end
