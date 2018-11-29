class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    taxons = @product.taxons
    @related_products = Spree::Product.in_taxons(taxons).
      includes(master: [:images, :default_price]).uniq.reject { |product| product == @product }
  end
end
