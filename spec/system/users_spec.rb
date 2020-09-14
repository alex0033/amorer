require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user, name: "user", self_introduction: "it is normal") }
  let!(:other_user) { create(:user, name: "other", self_introduction: "it is ohter") }

  it "show user_info" do
    sign_in user
    visit root_path
    within(:css, '.header .normal-links') do
      click_on "プロフィール"
    end
    expect(page).to have_current_path user_path(user)
    within(:css, '.main-contents') do
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.self_introduction)
      expect(page).not_to have_content(other_user.name)
      expect(page).not_to have_content(other_user.self_introduction)
      expect(page).to have_content("プロフィール編集はこちら")
    end
  end

  it "show other_user_info" do
    sign_in user
    visit user_path(other_user)
    within(:css, '.main-contents') do
      expect(page).to have_content(other_user.name)
      expect(page).to have_content(other_user.self_introduction)
      expect(page).not_to have_content(user.name)
      expect(page).not_to have_content(user.self_introduction)
      expect(page).not_to have_content("プロフィール編集はこちら")
    end
  end
end
