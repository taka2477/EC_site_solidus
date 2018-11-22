class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @taxons = @product.taxons
    @related_products = @taxons.flat_map { |taxon| Spree::Product.in_taxon(taxon) }.uniq.reject { |product| product == @product }
  end
end
