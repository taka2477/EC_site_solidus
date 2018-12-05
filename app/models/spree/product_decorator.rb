Spree::Product.class_eval do
  scope :includes_img_price, -> { includes(master: [:images, :default_price]) }
  scope :neat_display, ->(product) { where.not(id: product).distinct.limit 8 }
end
