require 'rails_helper'

RSpec.describe "Devise/Sessions", type: :system do
  let!(:user) { create(:user, password: password) }
  let(:password) { "password" }

  it "make session" do
    visit root_path
    within(:css, '.header .normal-links') do
      click_on 'ログイン'
    end
    expect(page).to have_current_path new_user_session_path
    # 不正な入力
    within(:css, '.form-box') do
      fill_in('user_email', with: "invalid@invalid.com")
      fill_in('user_password', with: password)
      click_on 'login_button'
      expect(page).to have_selector 'h2', text: "ログイン"
    end
    expect(page).to have_selector '.alert-warning'
    # 正しい入力
    within(:css, '.form-box') do
      fill_in('user_email', with: user.email)
      fill_in('user_password', with: password)
      click_on 'login_button'
    end
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path root_path
  end

  it "delete session" do
    sign_in user
    visit edit_user_registration_path
    within(:css, '.form-box') do
      click_on 'logout_button'
    end
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path root_path
  end
end
