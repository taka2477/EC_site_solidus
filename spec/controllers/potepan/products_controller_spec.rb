require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "GET #show" do
    let(:ruby) { create(:taxonomy) }
    let(:shirt) { create(:taxon, taxonomy: ruby, parent: ruby.root) }
    let!(:ruby_shirt) { create(:product, taxons: [shirt]) }
    let!(:related_shirt) { create(:product, taxons: [shirt]) }

    let(:category) { create(:taxonomy) }
    let(:mug) { create(:taxon, taxonomy: category, parent: category.root) }
    let!(:unrelated_product) { create(:product, taxons: [mug]) }

    before do
      get :show, params: { id: ruby_shirt.id }
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

    context "instance variable check" do
      it "assigns correct @product" do
        expect(assigns(:product)).to eq ruby_shirt
      end
    end

    context "existance check for related_products" do
      it "assigns existance for @related_shirt" do
        expect(assigns(:related_products)).to include related_shirt
      end

      it "assigns non-existance for @unrelated_product and @ruby_shirt" do
        expect(assigns(:related_products)).not_to contain_exactly(unrelated_product, ruby_shirt)
      end
    end

    context "shows fixed number of related_products" do
      let!(:related_shirt) { create_list(:product, 9, taxons: [shirt]) }

      it "assigns the number of related_products" do
        expect(assigns(:related_products).size).to eq 8
      end
    end
  end
end
