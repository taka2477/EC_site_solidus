class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_LIMITATION = 8

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = Spree::Product.
      other_products(@product.taxons, @product, RELATED_PRODUCTS_LIMITATION)
  end
end
