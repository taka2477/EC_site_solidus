class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_LIMITATION = 4

  def show
    @product = Spree::Product.find(params[:id])
    taxons = @product.taxons
    @related_products = Spree::Product.in_taxons(taxons).includes_img_price.
      neat_display(@product, RELATED_PRODUCTS_LIMITATION)
  end
end
