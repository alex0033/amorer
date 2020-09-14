require 'rails_helper'

RSpec.describe "Devise/Registrations", type: :system do
  let!(:user) { create(:user, password: password) }
  let!(:new_user) { build(:user, password: password) }
  let(:password) { "password" }

  it "makes user" do
    visit root_path
    within(:css, '.header .normal-links') do
      click_on "アカウント作成"
    end
    expect(page).to have_current_path new_user_registration_path
    # 不正な入力
    within(:css, '.form-box') do
      fill_in('user_email', with: "invalid")
      fill_in('user_password', with: password)
      fill_in('user_password_confirmation', with: password)
      click_on 'user_create_button'
      expect(page).to have_selector 'h2', text: "アカウント作成"
      expect(page).to have_selector '#error_explanation'
    end
    # 正しい入力
    within(:css, '.form-box') do
      fill_in('user_email', with: new_user.email)
      fill_in('user_password', with: "password")
      fill_in('user_password_confirmation', with: "password")
      click_on 'user_create_button'
    end
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path user_path(User.find_by(email: new_user.email))
  end

  it "update user" do
    sign_in user
    visit edit_user_registration_path
    name_changed = user.name + "change"
    # 不正な入力
    within(:css, '.form-box') do
      fill_in('user_name', with: name_changed)
      fill_in('user_current_password', with: "invalid")
      click_on 'user_update_button'
      expect(page).to have_selector 'h2', text: "プロフィール編集"
      expect(page).to have_selector '#error_explanation'
    end
    # 正しい入力
    within(:css, '.form-box') do
      fill_in('user_email', with: "valid@example.com")
      fill_in('user_current_password', with: "password")
      click_on 'user_update_button'
    end
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path user_path(user)
  end

  it "delete user", js: true do
    sign_in user
    visit edit_user_registration_path
    within(:css, '.form-box') do
      page.accept_confirm("本当に削除しますか？") do
        click_on 'user_delete_button'
      end
    end
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path root_path
  end
end
