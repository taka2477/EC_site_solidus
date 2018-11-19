require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  given(:category) { create(:taxonomy, name: "Brand") }
  given(:brand_kid) { category.root.children.create(name: "Ruby")  }
  given(:ruby_shirt) { brand_kid.leaves.create(name: "Ruby_shirt") }

  background do
    visit potepan_category_path(brand_kid.id)
  end

  scenario 'displays correct html' do
    html = page.html
  end

  # scenario 'shows correct links', js: true do
    # click_on 'Brand'
    # expect(page).to have_content 'Ruby'
    # click_link 'Ruby'
  # end

end
