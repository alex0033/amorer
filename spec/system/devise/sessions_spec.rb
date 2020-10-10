require 'rails_helper'

RSpec.describe "Devise/Sessions", type: :system do
  let!(:user) { create(:user, password: password) }
  let(:user_with_facebook) { create(:user_with_facebook) }
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
    expect(page).to have_current_path user_path(user)
  end

  it "make session with facebook" do
    facebook_mock(user_with_facebook)
    # ここまでの経路は"make sessionで確認済み"
    visit new_user_session_path
    click_on 'faceboook_login_button'
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path user_path(user_with_facebook)
  end

  it "cannot make session with facebook" do
    facebook_invalid_mock(user_with_facebook)
    # ここまでの経路は"make user"で確認済み"
    visit new_user_registration_path
    click_on 'faceboook_login_button'
    expect(page).to have_selector '.alert-warning'
    expect(page).to have_current_path new_user_registration_path
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
