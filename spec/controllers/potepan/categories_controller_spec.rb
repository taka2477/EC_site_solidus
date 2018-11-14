require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "GET #show" do
    subject { get :show, { params: params } }
    let(:params) { { id: categories.id } }
    let(:categories) { create(:categories) }

    it "response successfully" do
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      expect(response.status). to eq(200)
    end

    #it "responds correct template" do
    #  expect(response).to render_template :show
    #end
  end
end
