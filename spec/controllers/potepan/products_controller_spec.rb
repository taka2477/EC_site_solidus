require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "GET #show" do
    let(:product) { create :product }
    before { get :show, params: {id: product.id}}

    it "responds succcessfully" do
      get :show, params: { id: product.id }
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get :show, params: { id: product.id }
      expect(response). to have_http_status "200"
    end
  end
end
