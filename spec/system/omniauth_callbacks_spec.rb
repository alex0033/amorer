require 'rails_helper'

RSpec.describe "OmniauthCallbacks", type: :system do
  let(:new_user_with_facebook) { build(:user_with_facebook) }
  let(:user_with_facebook) { create(:user_with_facebook) }

  it "make user with facebook" do
    facebook_mock(new_user_with_facebook)
    visit new_user_registration_path
    expect do
      click_on 'faceboook_login_button'
    end.to change(User, :count).by(1)
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path user_path(User.find_by(email: new_user_with_facebook.email))
  end

  it "cannot make user with facebook" do
    facebook_invalid_mock(user_with_facebook)
    visit new_user_registration_path
    expect do
      click_on 'faceboook_login_button'
    end.to change(User, :count).by(0)
    expect(page).to have_selector '.alert-warning'
    expect(page).to have_current_path new_user_registration_path
  end

  it "make session with facebook" do
    facebook_mock(user_with_facebook)
    visit new_user_session_path
    click_on 'faceboook_login_button'
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path user_path(user_with_facebook)
  end

  it "cannot make session with facebook" do
    facebook_invalid_mock(user_with_facebook)
    visit new_user_registration_path
    click_on 'faceboook_login_button'
    expect(page).to have_selector '.alert-warning'
    expect(page).to have_current_path new_user_registration_path
  end
end
