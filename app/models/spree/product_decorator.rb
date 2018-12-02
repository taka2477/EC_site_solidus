Spree::Product.class_eval do
  scope :neat_display, -> { limit(8).distinct.reject { |product| product == @product }.shuffle }
  scope :take_img_price, -> { includes(master: [:images, :default_price]) }
end
