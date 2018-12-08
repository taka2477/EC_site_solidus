Spree::Product.class_eval do
  scope :includes_img_price, -> { includes(master: [:images, :default_price]) }
  scope :neat_display, ->(product, number) { where.not(id: product).distinct.order('rand()').limit(number) }
end
