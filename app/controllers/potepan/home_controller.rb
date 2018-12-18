class Potepan::HomeController < ApplicationController
  NEW_PRODUCTS_LIMIT = 8

  def index
    @latest_products = Spree::Product.new_products.limit(NEW_PRODUCTS_LIMIT)
  end
end
