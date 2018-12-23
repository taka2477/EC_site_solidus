Spree::Product.class_eval do
  scope :includes_img_price, -> { includes(master: [:images, :default_price]) }
  scope :other_products, ->(product, number) {
    in_taxons(product.taxons).includes_img_price.
      where.not(id: product).distinct.sample(number)
  }
end
