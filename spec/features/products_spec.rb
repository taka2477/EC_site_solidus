require 'rails_helper'

RSpec.feature "Products", type: :feature do
  given(:brand)    { create(:taxonomy, name: "brands") }
  given(:category) { create(:taxonomy, name: "categories") }

  given(:ruby)  { create(:taxon, name: "ruby", parent: brand.root, taxonomy: brand) }
  given(:rails) { create(:taxon, name: "rails", parent: brand.root, taxonomy: brand) }
  given(:bag)   { create(:taxon, name: "bags", parent: category.root, taxonomy: category) }
  given(:shirt) { create(:taxon, name: "shirt", parent: category.root, taxonomy: category) }

  given!(:rails_tote)  { create(:product, name: "rails_tote", price: '18.88', taxons: [rails, bag]) }
  given!(:rails_shirt) { create(:product, name: "rails_shirt", price: '15.55', taxons: [rails, shirt])}
  given!(:ruby_shirt)  { create(:product, name: "ruby_shirt", price: '17.77', taxons: [ruby, shirt]) }
  given!(:ruby_bag)    { create(:product, name: "ruby_bag", price: '16.66', taxons: [bag, ruby]) }

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
    within('.productsContent') do
      #不適切な商品が表示されていないこと
      expect(page).not_to have_content ruby_shirt.name
      expect(page).not_to have_content ruby_shirt.price
      expect(page).not_to have_content rails_tote.name
      expect(page).not_to have_content rails_tote.price
      #同一ブランド
      expect(page).to have_content ruby_bag.name
      expect(page).to have_content ruby_bag.price
      click_on ruby_bag.name
      expect(page).to have_current_path(potepan_product_path(ruby_bag.id))
      #同一カテゴリ
      visit potepan_product_path(ruby_shirt.id)
      expect(page).to have_content rails_shirt.name
      expect(page).to have_content rails_shirt.price
      click_on rails_shirt.name
      expect(page).to have_current_path(potepan_product_path(rails_shirt.id))
    end
  end
end
