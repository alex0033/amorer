require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "#index" do
    context "when not singed_in" do
      before do
        get messages_path
      end

      it_behaves_like "filter not_signed_in_user without Ajax"
    end

    context "when singed_in" do
      let!(:message1) { create(:message, sender: sender, receiver: receiver) }
      let!(:message2) { create(:message, sender: sender, receiver: receiver) }
      let!(:message3) { create(:message, sender: receiver, receiver: sender) }
      let(:sender) { create(:user) }
      let(:receiver) { create(:user) }

      #より細かい場合分けもする？？
      before do
        singed_in receiver
        get messages_path
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to include(message1.title) }
      it { expect(response.body).to include(message2.title) }
      it { expect(response.body).not_to include(message3.title) }
    end
  end

  describe "#new" do
    context "when not singed_in" do
      before do
        get new_message_path
      end

      it_behaves_like "filter not_signed_in_user without Ajax"
    end

    context "when singed_in" do
      let(:sender) { create(:user) }
      let(:receiver) { create(:user) }

      before do
        get new_messages_path
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to include("メッセージ作成") }
    end
  end

  describe "#create" do
    let(:sender) { create(:user) }
    let(:receiver) { create(:user) }
    let(:message_built) { build(:message, sender: sender, receiver: receiver) }
    let(:valid_params) do
      {
        message: {
          title: message_built.title,
          recceiver: receiver,
          kind: message_built.kind,
          content: message_built.content,
        },
      }
    end
    let(:invalid_params) do
      {
        message: {
          title: "",
          recceiver: receiver,
          kind: message_built.kind,
          content: message_built.content,
        },
      }
    end
    context "when not singed_in" do
      before do
        get messages_path, params: valid_params
      end

      it_behaves_like "filter not_signed_in_user without Ajax"
      it { expect(Message.find_by(title: message_built.title)).to be_falsy }
    end

    context "when singed_in" do
      context "when invalid params" do
        before do
          signed_in
          get messages_path, params: invalid_params
        end

        it { expect(response.status).to eq(200) }
        it { expect(response.body).to include("メッセージ作成") }
        it { expect(Message.find_by(title: message_built.title)).to be_falsy }
      end

      context "when valid params" do
        before do
          signed_in
          get messages_path, params: valid_params
        end

        it { expect(response.status).to eq(302) }
        it { expect(response).to redirect_to message_path(Message.find_by(title: message_built.title)) }
        it { expect(Message.find_by(title: message_built.title)).to be_truthy }
      end
    end
  end

  describe "#show" do
    context "when not singed_in" do
      before do
        get messages_path(message)
      end

      it_behaves_like "filter not_signed_in_user without Ajax"
    end

    context "when singed_in" do
      let!(:message) { create(:message, sender: sender, receiver: receiver) }
      let!(:other_message) { create(:message, sender: receiver, receiver: sender) }
      let(:sender) { create(:user) }
      let(:receiver) { create(:user) }

      before do
        get messages_path(message)
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to include(message.title) }
      it { expect(response.body).not_to include(other_message.title) }
    end
  end
end
