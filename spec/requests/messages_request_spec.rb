require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "#index" do
    context "when not signed_in" do
      before do
        get messages_path
      end

      it_behaves_like "filter not_signed_in_user without Ajax"
    end

    context "when signed_in" do
      let!(:message1) { create(:message, sender: sender, receiver: receiver) }
      let!(:message2) { create(:message, sender: sender, receiver: receiver) }
      let!(:message3) { create(:message, sender: receiver, receiver: sender) }
      let(:sender) { create(:user) }
      let(:receiver) { create(:user) }

      #より細かい場合分けもする？？
      before do
        sign_in receiver
        get messages_path
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to include(message1.title) }
      it { expect(response.body).to include(message2.title) }
      it { expect(response.body).not_to include(message3.title) }
    end
  end

  describe "#new" do
    context "when not signed_in" do
      before do
        get new_message_path
      end

      it_behaves_like "filter not_signed_in_user without Ajax"
    end

    context "when signed_in" do
      let(:sender) { create(:user) }

      before do
        sign_in sender
        get new_message_path
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to include("メッセージ作成") }
    end
  end

  describe "#create" do
    let!(:sender) { create(:user) }
    let!(:receiver) { create(:user) }
    let(:message_built) { build(:message, sender: sender, receiver: receiver) }
    let(:valid_params) do
      {
        receiver_id: receiver.id,
        message: {
          title: message_built.title,
          kind: message_built.kind,
          content: message_built.content,
        },
      }
    end
    let(:invalid_params) do
      {
        receiver_id: receiver.id,
        message: {
          title: "",
          kind: message_built.kind,
          content: message_built.content,
        },
      }
    end
    context "when not signed_in" do
      before do
        post messages_path, params: valid_params
      end

      it_behaves_like "filter not_signed_in_user without Ajax"
      it { expect(Message.find_by(title: message_built.title)).to be_falsy }
    end

    context "when signed_in" do
      context "when invalid params" do
        before do
          sign_in sender
          post messages_path, params: invalid_params
        end

        it { expect(response.status).to eq(200) }
        it { expect(response.body).to include("メッセージ作成") }
        it { expect(Message.find_by(title: message_built.title)).to be_falsy }
      end

      context "when valid params" do
        before do
          sign_in sender
          post messages_path, params: valid_params
        end

        it { expect(response.status).to eq(302) }
        it { expect(response).to redirect_to message_path(Message.find_by(title: message_built.title)) }
        it { expect(Message.find_by(title: message_built.title)).to be_truthy }
      end
    end
  end

  describe "#show" do
    let!(:message) { create(:message, sender: sender, receiver: receiver) }
    let!(:other_message) { create(:message, sender: receiver, receiver: sender) }
    let(:sender) { create(:user) }
    let(:receiver) { create(:user) }

    context "when not signed_in" do
      before do
        get message_path(message)
      end

      it_behaves_like "filter not_signed_in_user without Ajax"
    end

    context "when signed_in" do
      before do
        sign_in receiver
        get message_path(message)
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to include(message.title) }
      it { expect(response.body).not_to include(other_message.title) }
    end
  end
end
