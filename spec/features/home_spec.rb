require 'rails_helper'

RSpec.feature "Home", type: :feature do
  given(:brand) { create(:taxonomy, name: "brands") }
  given(:ruby) { create(:taxon, name: "ruby", parent: brand.root, taxonomy: brand) }
  given!(:ruby_shirt) { create(:product, name: "ruby_shirt", taxons: [ruby]) }

  background do
    visit potepan_path
  end

  scenario "user can see and visit latest_products page from home" do
    within('.featuredProducts') do
      expect(page).to have_content ruby_shirt.name
      expect(page).to have_content ruby_shirt.display_price
      click_on ruby_shirt.name
      expect(page).to have_current_path(potepan_product_path(ruby_shirt.id))
    end
  end
end
