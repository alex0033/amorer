require 'rails_helper'

RSpec.describe "Devise/Registrations", type: :system do
  let!(:user) { create(:user, password: password) }
  let!(:new_user) { build(:user, password: password) }
  let(:password) { "password" }

  it "makes user" do
    visit root_path
    within(:css, '.header') do
      click_on "アカウント作成"
    end
    expect(page).to have_current_path new_user_registration_path
    # 不正な入力
    within(:css, '.form-box') do
      fill_in('user_email', with: "invalid")
      fill_in('user_password', with: password)
      fill_in('user_password_confirmation', with: password)
      click_on "アカウント作成"
      expect(page).to have_content("アカウント作成")
    end
    # 正しい入力
    within(:css, '.form-box') do
      fill_in('user_email', with: new_user.email)
      fill_in('user_password', with: "password")
      fill_in('user_password_confirmation', with: "password")
      click_on "アカウント作成"
    end
    expect(page).to have_current_path user_path(User.find_by(email: new_user.email))
    # flash_massage??
  end

  it "update user" do
    sign_in user
    visit edit_user_registration_path
    name_changed = user.name + "change"
    # 不正な入力
    within(:css, '.form-box') do
      fill_in('user_name', with: name_changed)
      fill_in('user_current_password', with: "invalid")
      click_on "更新"
      expect(page).to have_content("プロフィール編集")
    end
    # ここでエラーメッセージ確認？？
    # 正しい入力
    within(:css, '.form-box') do
      fill_in('user_email', with: "valid@example.com")
      fill_in('user_current_password', with: "password")
      click_on "更新"
    end
    expect(page).to have_current_path user_path(user)
    # flash_massage??
  end

  it "delete user", js: true do
    sign_in user
    visit edit_user_registration_path
    within(:css, '.form-box') do
      page.accept_confirm("本当に削除しますか？") do
        click_on "アカウント削除"
      end
    end
    expect(page).to have_current_path root_path
  end
end
