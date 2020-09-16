RSpec.shared_examples "filter not_signed_in_user with Ajax" do
  it { expect(response.status).to eq(200) }
  it { expect(response).to redirect_to new_user_session_path }
end

RSpec.shared_examples "filter not_signed_in_user without Ajax" do
  it { expect(response.status).to eq(302) }
  it { expect(response).to redirect_to new_user_session_path }
end
