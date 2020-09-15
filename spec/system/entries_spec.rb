require 'rails_helper'

RSpec.describe "Entries", type: :system do
  let!(:entry) { create(:entry, user: user, job: entered_job) }
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:job) { create(:job, user: other_user) }
  let!(:entered_job) { create(:job, user: other_user) }

  it "prevents not_signed_user from making entry" do
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

  it "makes entry and destroys the entry" do
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

  it "destroys the entry and make the entry again" do
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
end
