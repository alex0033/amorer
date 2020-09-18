require 'rails_helper'

RSpec.describe "Entries", type: :system do
  let!(:entry) { create(:entry, user: user, job: entered_job) }
  let(:user) { create(:user) }
  let(:other_user) { create(:user, name: "other") }
  let!(:job) { create(:job, user: other_user) }
  let!(:entered_job) { create(:job, user: other_user) }

  it "prevents not_signed_user from making entry", js: true do
    visit root_path
    within(:css, '.jobs') do
      click_on job.title
    end
    within(:css, '#entry-button') do
      click_on "応募する"
    end
    expect(page).to have_current_path new_user_session_path
    expect(page).to have_selector '.alert-warning'
  end

  it "makes entry and destroys the entry", js: true do
    sign_in user
    visit root_path
    within(:css, '.jobs') do
      click_on job.title
    end
    within(:css, '#entry-button') do
      click_on "応募する"
    end
    expect(page).to have_content("応募中")
    expect(page).not_to have_content("応募する")
    within(:css, '#entry-button') do
      click_on "応募中"
    end
    expect(page).to have_content("応募する")
    expect(page).not_to have_content("応募中")
  end

  it "destroys the entry and make the entry again", js: true do
    sign_in user
    visit root_path
    within(:css, '.jobs') do
      click_on entered_job.title
    end
    within(:css, '#entry-button') do
      click_on "応募中"
    end
    expect(page).to have_content("応募する")
    expect(page).not_to have_content("応募中")
    within(:css, '#entry-button') do
      click_on "応募する"
    end
    expect(page).to have_content("応募中")
    expect(page).not_to have_content("応募する")
  end

  it "shows entry_users at modal", js: true do
    sign_in other_user
    visit job_path(entered_job)
    expect(page).not_to have_selector('body.modal-open')
    expect(page).to have_content("応募ユーザー表示")
    within(:css, '#entry-button') do
      click_on "応募ユーザー表示"
    end
    expect(page).to have_selector('body.modal-open')
    within(:css, '#entry-users-modal') do
      expect(page).to have_content(user.name)
    end
  end
end
