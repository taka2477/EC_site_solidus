class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    taxons = @product.taxons
    @related_products = Spree::Product.take_img_price.in_taxons(taxons).neat_display
  end
end
