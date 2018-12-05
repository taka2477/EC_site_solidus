class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    taxons = @product.taxons
    @related_products = Spree::Product.in_taxons(taxons).includes_img_price.
      neat_display(@product).shuffle
  end
end
