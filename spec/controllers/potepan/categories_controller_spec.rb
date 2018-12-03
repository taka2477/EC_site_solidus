require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "GET #show" do
    let!(:category) { create(:taxonomy, name: "category") }
    let(:bag) { create(:taxon, name: "bag", parent: category.root, taxonomy: category) }
    let(:bag_product) { create(:product, taxons: [bag]) }

    let!(:brand) { create(:taxonomy, name: "brand") }
    let(:ruby) { create(:taxon, name: "Ruby", parent: brand.root, taxonomy: brand) }
    let(:ruby_product) { create(:product, taxons: [ruby]) }

    before do
      get :show, params: { id: bag.id }
    end

    context "response check" do
      it "response successfully" do
        expect(response).to be_successful
      end

      it "returns a 200 response" do
        expect(response.status).to eq(200)
      end

      it "responds correct template" do
        expect(response).to render_template :show
      end
    end

    context "instance variables check" do
      it "assigns @taxonomies" do
        expect(assigns(:taxonomies)).to contain_exactly(category, brand)
      end

      it "assigns correct @taxon" do
        expect(assigns(:taxon)).to eq bag
      end

      it "assigns correct @product" do
        expect(assigns(:products)).to contain_exactly(bag_product)
      end

      it "assigns incorrect @product" do
        expect(assigns(:products)).not_to include ruby_product
      end
    end
  end
end
