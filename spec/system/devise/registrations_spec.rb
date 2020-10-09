require 'rails_helper'

RSpec.describe "Devise/Registrations", type: :system do
  let!(:user) { create(:user) }
  let!(:new_user) { build(:user) }
  let(:password) { "password" }
  let(:user_with_image_info) { create(:user, x: 0, y: 0, width: 50, height: 50) }
  let(:first_image_path) { 'spec/factories/file_data/jpg_file.jpg' }
  let(:changed_image_path) { 'spec/factories/file_data/another_file.png' }

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
      fill_in('user_password', with: password)
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
      fill_in('user_email', with: " ")
      click_on 'user_update_button'
      expect(page).to have_selector 'h2', text: "プロフィール編集"
      expect(page).to have_selector '#error_explanation'
    end
    # 正しい入力
    within(:css, '.form-box') do
      fill_in('user_name', with: name_changed)
      fill_in('user_email', with: user.email)
      click_on 'user_update_button'
    end
    expect(page).to have_content name_changed
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

  it "attach image", js: true do
    sign_in user
    visit edit_user_registration_path
    # 初めて画像入力
    within(:css, '.form-box') do
      expect(page).not_to have_selector '.cropper-container'
      attach_file('user_image', first_image_path)
      fill_in('user_name', with: user.name)
      expect(page).to have_selector '.cropper-container'
      click_on 'user_update_button'
    end
    expect(page).to have_selector "img[src$='jpg_file.jpg']"
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path user_path(user)
  end

  it "attach image again", js: true do
    user_with_image_info.image.attach(
      io: File.open(first_image_path),
      filename: 'jpg_file.jpg',
      content_type: 'image/jpg'
    )
    sign_in user_with_image_info
    visit edit_user_registration_path
    # 不正入力
    within(:css, '.form-box') do
      # 最初に設定した画像がプレビューとして表示される
      expect(page).to have_selector "img[src$='jpg_file.jpg']"
      expect(page).not_to have_selector '.cropper-container'
      attach_file('user_image', changed_image_path)
      fill_in('user_name', with: user_with_image_info.name)
      fill_in('user_email', with: " ")
      expect(page).to have_selector '.cropper-container'
      click_on 'user_update_button'
      expect(page).to have_selector 'h2', text: "プロフィール編集"
      expect(page).to have_selector '#error_explanation'
    end
    # 正しい入力
    within(:css, '.form-box') do
      # 最初に設定した画像がプレビューとして表示される
      expect(page).to have_selector "img[src$='jpg_file.jpg']"
      expect(page).not_to have_selector "img[src$='another_file.png']"
      fill_in('user_email', with: user_with_image_info.email)
      attach_file('user_image', changed_image_path)
      fill_in('user_name', with: user_with_image_info.name)
      click_on 'user_update_button'
    end
    # 画像の変更を確認
    expect(page).to have_selector "img[src$='another_file.png']"
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path user_path(user_with_image_info)
  end
end
