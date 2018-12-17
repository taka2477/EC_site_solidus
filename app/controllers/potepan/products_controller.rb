class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_LIMIT = 4

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = Spree::Product.
      other_products(@product).limit(RELATED_PRODUCTS_LIMIT)
  end
end
