require 'rails_helper'

RSpec.feature "Products", type: :feature do
  given(:brand) { create(:taxonomy, name: "brands") }
  given(:ruby) { create(:taxon, name: "ruby", parent: brand.root, taxonomy: brand) }
  given!(:ruby_shirt) { create(:product, name: "ruby_shirt", price: '17.77', taxons: [ruby]) }

  given(:category) { create(:taxonomy, name: "categories") }
  given(:bag) { create(:taxon, name: "bags", parent: category.root, taxonomy: category) }
  given!(:ruby_bag) { create(:product, name: "ruby_bag", price: '16.66', taxons: [bag]) }

  background do
    visit potepan_product_path(ruby_shirt.id)
  end

  scenario 'has correct page title and path' do
    expect(page).to have_current_path(potepan_product_path(ruby_shirt.id))
    expect(page).to have_title ruby_shirt.name
    click_on 'BIGBAG Store logo'
    expect(page).to have_current_path(potepan_path)
    expect(page).to have_title 'BIGBAG Store'
    click_on 'Home'
    expect(page).to have_current_path(potepan_path)
    expect(page).to have_title 'BIGBAG Store'
  end

  scenario 'shows correct product name and link' do
    within('.lightSection') do
      expect(page).to have_selector 'h2', text: ruby_shirt.name
      expect(page).not_to have_selector 'h2', text: ruby_bag.name
      expect(page).to have_selector '.breadcrumb', text: ruby_shirt.name
      expect(page).not_to have_selector '.breadcrumb', text: ruby_bag.name
      expect(page).to have_link 'Home'
    end
  end

  scenario 'displays the product information properly' do
    within('.singleProduct') do
      #リンク
      expect(page).to have_current_path(potepan_product_path(ruby_shirt.id))
      expect(page).to have_link '一覧ページへ戻る'
      #product画像
      expect(page).to have_css '#carousel'
      expect(page).to have_css '.glyphicon-chevron-left'
      expect(page).to have_css '.glyphicon-chevron-right'
      #product概要
      expect(page).to have_selector 'h2', text: ruby_shirt.name
      expect(page).not_to have_selector 'h2', text: ruby_bag.name
      expect(page).to have_selector 'h3', text: ruby_shirt.price
      expect(page).not_to have_selector 'h3', text: ruby_bag.price
      expect(page).to have_content ruby_shirt.description
    end
    # within('.productsContent') do
      # expect(page).to have_css '.clearfix'
    # end
  end
end
     #click_on
    #  click_on ruby_shirt.name
    #  expect(page).to have_current_path(potepan_product_path(ruby_shirt.id))
    #  expect(page).to have_title ruby_shirt.name
  #  end

  # scenario 'examines links of the taxon and visibleness of the product' do
  #   within('.navbar-side-collapse') do
  #     find_link(bag.name).visible?
  #     find_link(ruby.name).click
  #     expect(page).to have_current_path(potepan_category_path(ruby.id))
  #   end
  #   within('.productBox') do
  #     expect(page).to have_content ruby_shirt.name
  #     expect(page).not_to have_content ruby_bag.name
  #   end
  # end
