require 'rails_helper'

RSpec.describe "Messages", type: :system do
  let(:sender) { create(:user) }
  let(:receiver) { create(:user) }
  let!(:message1) { create(:message, sender: sender, receiver: receiver) }
  let!(:message2) { create(:message, sender: sender, receiver: receiver) }
  let!(:message3) { create(:message, sender: receiver, receiver: sender) }
  let(:new_message) { build(:message, sender: sender) }

  it "makes message" do
    sign_in sender
    visit user_path(receiver)
    within(:css, '.main-contents') do
      click_on "メッセージを送る"
    end
    expect(page).to have_current_path new_message_path
    # 不正な入力
    within(:css, '.form-box') do
      fill_in('message_title', with: "")
      fill_in('kind', with: new_message.kind)
      fill_in('message_content', with: new_message.kind)
      click_on 'message_create_button'
      expect(page).to have_selector 'h2', text: "メッセージ作成"
      expect(page).to have_selector '#error_explanation'
    end
    # 正しい入力
    within(:css, '.form-box') do
      fill_in('message_title', with: new_message.title)
      fill_in('kind', with: new_message.kind)
      fill_in('message_content', with: new_message.kind)
      click_on 'message_create_button'
      expect(page).to have_selector 'h2', text: "メッセージ作成"
      expect(page).to have_selector '#error_explanation'
    end
    expect(page).to have_selector '.alert-success'
    expect(page).to have_current_path message_path(Message.find_by(title: new_message.title))
  end

  it "show messages" do
    sign_in sender
    visit root_path
    within(:css, '.header .normal-links') do
      click_on "メッセージ"
    end
    expect(page).to have_current_path messages_path
    expect(page).to have_content(message1.title)
    expect(page).to have_content(message2.title)
    expect(page).not_to have_content(message3.title)
    within(:css, '.main-contents') do
      click_on message1.title
    end
    expect(page).to have_current_path message_path(message1)
    expect(page).to have_content(message1.title)
    expect(page).to have_content(message1.sender.name)
    expect(page).to have_content(message1.receiver.name)
    expect(page).to have_content(message1.content)
    expect(page).not_to have_content(message2.title)
  end
end
