require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "GET #show" do
    let(:product) { create :product }

    before { get :show, params: { id: product.id } }

    it "responds successfully" do
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      expect(response.status). to eq(200)
    end

    it "responds correct template " do
      expect(response).to render_template :show
    end

    it "assigns product" do
      expect(assigns(:product)).to eq product
    end
  end
end
