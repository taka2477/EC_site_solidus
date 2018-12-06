require 'rails_helper'

RSpec.feature "Products", type: :feature do
  given(:brand) { create(:taxonomy, name: "brand") }
  given(:ruby) { create(:taxon, name: "ruby", parent: brand.root, taxonomy: brand) }
  given!(:ruby_bag) { create(:product, name: "ruby_bag", price: '16.66', taxons: [ruby]) }
  given!(:ruby_shirt) { create(:product, name: "ruby_shirt", price: '17.77', taxons: [ruby]) }

  given(:category) { create(:taxonomy, name: "category") }
  given(:shoes) { create(:taxon, name: "shoes", parent: category.root, taxonomy: category) }
  given!(:unrelated_shoes) { create(:product, name: "unrelated_shoes", price: '99.99', taxons: [shoes]) }
  given!(:ruby_shoes) { create(:product, name: "ruby_shoes", price: '88.88', taxons: [shoes, ruby]) }

  background do
    visit potepan_product_path(ruby_shirt.id)
  end

  scenario 'has correct page title and path' do
    expect(page).to have_current_path(potepan_product_path(ruby_shirt.id))
    expect(page).to have_title ruby_shirt.name
  end

  scenario 'shows correct main product name and link to Home' do
    within('.lightSection') do
      expect(page).to have_selector 'h2', text: ruby_shirt.name
      within('.breadcrumb') do
        expect(page).to have_link 'Home'
        expect(page).to have_content ruby_shirt.name
      end
    end
  end

  context 'using ruby_shoes' do
    background do
      visit potepan_product_path(ruby_shoes.id)
    end

    scenario 'contents of main product properly' do
      expect(page).to have_selector 'h2', text: ruby_shoes.name
      expect(page).to have_selector 'h3', text: ruby_shoes.price
      expect(page).to have_content ruby_shoes.description
    end

    scenario 'user can visit category pages by clicking' do
      within('.singleProduct') do
        expect(page).to have_current_path(potepan_product_path(ruby_shoes.id))
        within('.media-body', visible: false) do
          expect(page).to have_link "To Categories"
          click_on "To Categories"
          expect(page).to have_current_path(potepan_category_path(shoes.id))
          visit potepan_product_path(ruby_shoes.id)
          expect(page).to have_link "To Brand"
          click_on "To Brand"
          expect(page).to have_current_path(potepan_category_path(ruby.id))
        end
      end
    end
  end

  scenario 'shows only related_products below the main product' do
    within('.productsContent') do
      # 不適切な商品が表示されていないこと
      expect(page).not_to have_content unrelated_shoes.name
      expect(page).not_to have_content unrelated_shoes.price
      # 関連商品が表示されていること
      expect(page).to have_content ruby_bag.name
      expect(page).to have_content ruby_bag.price
      expect(page).to have_content ruby_shoes.name
      expect(page).to have_content ruby_shoes.price
      # 関連商品のリンクが正しいこと
      click_on ruby_bag.name
      expect(page).to have_current_path(potepan_product_path(ruby_bag.id))
      visit potepan_product_path(ruby_shirt.id)
      click_on ruby_shoes.name
      expect(page).to have_current_path(potepan_product_path(ruby_shoes.id))
    end
  end
end
