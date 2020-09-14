require 'rails_helper'

RSpec.describe "BasicPages", type: :request do
  describe "GET root" do
    it "returns http success" do
      get root_path
      expect(response.status).to eq(200)
    end
  end

  describe "GET /policy" do
    it "returns http success" do
      get policy_path
      expect(response.status).to eq(200)
    end
  end
end
