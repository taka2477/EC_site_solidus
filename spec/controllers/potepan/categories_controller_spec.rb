require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "GET #show" do
    let!(:category) { create(:taxonomy, name: "categories") }
    let(:bags) { create(:taxon, name: "Bags", parent: category.root, taxonomy: category) }
    let(:bags_product) { create(:product, taxons: [bags]) }

    let!(:brand) { create(:taxonomy, name: "brands") }
    let(:ruby) { create(:taxon, name: "Ruby", parent: category.root, taxonomy: category) }
    let(:ruby_product) { create(:product, taxons: [ruby]) }

    before do
      get :show, { params: { id: bags.id } }
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
        expect(assigns(:taxon)).to eq bags
      end

      it "assigns incorrect @taxon" do
        expect(assigns(:taxon)).not_to eq ruby
      end

      it "assigns correct @product" do
        expect(assigns(:products)).to contain_exactly(bags_product)
      end

      it "assigns incorrect @product" do
        expect(assigns(:products)).not_to include ruby_product
      end
    end
  end
end
