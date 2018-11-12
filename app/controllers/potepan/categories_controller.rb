class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all
    @products = Spree::Product.joins(:taxons).where(Spree::Taxon.table_name => { id: @taxon.id })
  end
end
