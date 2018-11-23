require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  given(:category) { create(:taxonomy, name: "brand") }
  given(:ruby) { create(:taxon, name: "ruby", parent: category.root, taxonomy: category) }
  given!(:ruby_shirt) { create(:product, name: "ruby_shirt", taxons: [ruby]) }

  given(:category) { create(:taxonomy, name: "categories") }
  given(:bag) { create(:taxon, name: "bags", parent: category.root, taxonomy: category) }
  given!(:ruby_bag) { create(:product, name: "ruby_bag", taxons: [bag]) }

  background do
    visit potepan_category_path(ruby.id)
  end

  scenario 'has correct page title and path' do
    expect(page).to have_current_path(potepan_category_path(ruby.id))
    expect(page).to have_title ruby.name
    click_on ruby_shirt.name
    expect(page).to have_current_path(potepan_product_path(ruby_shirt.id))
    expect(page).to have_title ruby_shirt.name
    click_on 'BIGBAG Store logo'
    expect(page).to have_current_path(potepan_path)
  end

  scenario 'examines links of the taxon and visibleness of the product' do
    within('.navbar-side-collapse') do
      find_link(bag.name).visible?
      find_link(ruby.name).click
      expect(page).to have_current_path(potepan_category_path(ruby.id))
    end
    within('.productBox') do
      expect(page).to have_content ruby_shirt.name
      expect(page).not_to have_content ruby_bag.name
    end
  end
end
