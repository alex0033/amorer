require 'rails_helper'

RSpec.describe "Jobs", type: :system do
  let!(:job) { create(:job, user: user) }
  let!(:other_job) { create(:job, user: other_user) }
  let!(:user) { create(:user) }
  let(:other_user) { create(:user) }

  it "show jobs" do
    sign_in user
    visit root_path
    within(:css, '.header') do
      click_on "アモリル"
    end
    expect(page).to have_content(job.title)
    expect(page).to have_content(other_job.title)
    within(:css, '.main-contents') do
      click_on job.title
    end
    expect(page).to have_current_path job_path(job)
    expect(page).to have_link('job_edit_button')
    within(:css, '.header') do
      click_on "アモリル"
    end
    within(:css, '.main-contents') do
      click_on other_job.title
    end
    expect(page).to have_current_path job_path(other_job)
    expect(page).not_to have_link("求人広告を変更したい場合はココをクリック")
  end

  it "makes job" do
    sign_in user
    visit root_path
    within(:css, '.header .normal-links') do
      click_on "求人広告掲載"
    end
    expect(page).to have_current_path new_job_path
    # 不正な入力
    within(:css, '.form-box') do
      fill_in('job_title', with: "")
      select("時給", from: "報酬")
      fill_in('job_reward_min_amount', with: 1000)
      fill_in('job_reward_max_amount', with: 1300)
      fill_in('job_explanation', with: "It is very good")
      click_on 'job_create_button'
      expect(page).to have_selector 'h2', text: "求人作成"
      expect(page).to have_selector '#error_explanation'
    end
    # 正しい入力
    within(:css, '.form-box') do
      fill_in('job_title', with: "Job Title")
      select("時給", from: "報酬")
      fill_in('job_reward_min_amount', with: 1000)
      fill_in('job_reward_max_amount', with: 1300)
      fill_in('job_explanation', with: "It is very good")
      click_on "作成"
    end
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path job_path(Job.find_by(title: "Job Title"))
  end

  it "update job" do
    sign_in user
    visit job_path(job)
    within(:css, '.main-contents') do
      click_on 'job_edit_button'
    end
    title_changed = job.title + "change"
    # 不正な入力
    within(:css, '.form-box') do
      fill_in('job_title', with: title_changed)
      select("時給", from: "報酬")
      fill_in('job_reward_min_amount', with: job.reward_min_amount)
      fill_in('job_reward_max_amount', with: job.reward_max_amount)
      fill_in('job_explanation', with: "")
      click_on 'job_update_button'
      expect(page).to have_selector 'h2', text: "求人編集"
      expect(page).to have_selector '#error_explanation'
    end
    # 正しい入力
    within(:css, '.form-box') do
      fill_in('job_title', with: title_changed)
      select("時給", from: "報酬")
      fill_in('job_reward_min_amount', with: job.reward_min_amount)
      fill_in('job_reward_max_amount', with: job.reward_max_amount)
      fill_in('job_explanation', with: "valid explanation")
      click_on 'job_update_button'
    end
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path job_path(job)
  end

  it "delete job", js: true do
    sign_in user
    visit edit_job_path(job)
    within(:css, '.form-box') do
      page.accept_confirm("本当に削除しますか？") do
        click_on 'job_delete_button'
      end
    end
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path root_path
  end
end
