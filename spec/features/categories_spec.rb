require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  given(:category) { create(:taxonomy, name: "Brand") }
  given(:brand_kid) { category.taxons.create(name: "Ruby") }
  given(:ruby_shirt) { brand_kid.leaves.create(name: "Ruby_shirt") }

  background do
    visit potepan_category_path(brand_kid.id)
  end

  scenario 'has correct title' do
    expect(page).to have_title brand_kid.name
    visit potepan_category_path(ruby_shirt.id)
    expect(page).to have_title ruby_shirt.name
  end

  scenario 'shows contents properly' do
    click_on brand_kid.name
    expect(current_path).to match potepan_category_path(brand_kid.id)
    expect(page).to have_content brand_kid.name
    visit potepan_category_path(ruby_shirt.id)
    expect(page).to have_content ruby_shirt.name
    click_on 'BIGBAG Store logo'
    expect(current_path).to match potepan_path
  end
end
