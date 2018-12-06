Spree::Product.class_eval do
  RELATED_PRODUCTS_LIMITATION = 8
  scope :includes_img_price, -> { includes(master: [:images, :default_price]) }
  scope :neat_display, ->(product) { where.not(id: product).distinct.limit(RELATED_PRODUCTS_LIMITATION) }
end
