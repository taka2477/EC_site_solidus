require 'rails_helper'

RSpec.describe Potepan::HomeController, type: :controller do
  describe "GET #index" do
    before { get :index }

    it "responds successfully" do
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      expect(response.status).to eq(200)
    end

    it "responds correct template" do
      expect(response).to render_template :index
    end

    context "latest_products check" do
      let!(:latest_products) { create_list(:product, 8) }

      it "assigns correct products" do
        expect(assigns(:latest_products)).to match latest_products
      end

      it "assigns correct number of products" do
        expect(assigns(:latest_products).size).to eq 8
      end
    end

    context "when the number of latest_products is 9" do
      let!(:latest_products) { create_list(:product, 9) }

      it "assigns correct number of products" do
        expect(assigns(:latest_products).size).to eq 8
      end
    end
  end
end
