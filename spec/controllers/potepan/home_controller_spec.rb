require 'rails_helper'

RSpec.describe Potepan::HomeController, type: :controller do
  describe "GET #index" do
    before { get :index }

    it "responds successfully" do
      expect(response). to be_successful
    end

    it "returns a 200 response" do
      expect(response.status). to eq(200)
    end

    it "responds correct template" do
      expect(response).to render_template :index
    end
  end
end
