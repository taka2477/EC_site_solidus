class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @taxon = Spree::Taxon.find(params[:id])
    @images = Spree::Product.in_taxon(@taxon)
  end
end
