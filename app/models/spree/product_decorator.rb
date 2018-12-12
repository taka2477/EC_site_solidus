Spree::Product.class_eval do
  scope :includes_img_price, -> { includes(master: [:images, :default_price]) }
  scope :other_products, ->(product_taxons, product, number) {
    in_taxons(product_taxons).includes_img_price.
      where.not(id: product).distinct.
      order(Arel.sql('rand()')).limit(number)
  }
end
