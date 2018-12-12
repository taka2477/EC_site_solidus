require 'rails_helper'

RSpec.feature "Products", type: :feature do
  given(:brand) { create(:taxonomy, name: "Brand") }
  given(:ruby) { create(:taxon, name: "Ruby", parent: brand.root, taxonomy: brand) }
  given!(:ruby_bag) { create(:product, name: "RubyBag", price: '16.66', taxons: [ruby]) }
  given!(:ruby_shirt) { create(:product, name: "RubyShirt", price: '17.77', taxons: [ruby]) }

  given(:category) { create(:taxonomy, name: "Category") }
  given(:shoes) { create(:taxon, name: "Shoes", parent: category.root, taxonomy: category) }
  given!(:unrelated_shoes) { create(:product, name: "HogeShoes", price: '99.99', taxons: [shoes]) }
  given!(:ruby_shoes) { create(:product, name: "RubyShoes", price: '88.88', taxons: [shoes, ruby]) }

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

  scenario 'displays the contents of main product properly' do
    expect(page).to have_selector 'h2', text: ruby_shirt.name
    expect(page).to have_selector 'h3', text: ruby_shirt.price
    expect(page).to have_content ruby_shirt.description
  end

  scenario 'user can visit category pages by clicking' do
    within('.singleProduct') do
      expect(page).to have_current_path(potepan_product_path(ruby_shirt.id))
      within('.media-body') do
        expect(page).to have_link "一覧ページへ戻る"
        click_on "一覧ページへ戻る"
        expect(page).to have_current_path(potepan_category_path(ruby.id))
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
