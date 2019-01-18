# Heroku
https://potepan-solidus-ec-site.herokuapp.com/potepan/categories/1

# ポテパンキャンプECサイトリポジトリ

開発環境
Ruby 2.5.1
Rails 5.2.1
MySQL 5.7
VScode 1.29

# 課題として実装したこと
## Task 1
・Rails環境開発構築

## Task 2
・商品詳細ページのテンプレート（potepan/sample/single_product.html.erb）を参考にして、商品詳細ページを実装してください。
・商品のモデル名は Spree::Product です。
・実装するパス は /potepan/products としてください。
・ルーティングの定義には適切に namespace を利用してください。
・app/views/layouts/application.html.erb を使用して、ヘッダーの共通化を行ってください。

## Task 3
・カテゴリーページのテンプレート（potepan/sample/product_grid_left_sidebar.html.erb）に選択したカテゴリーの商品が一覧で表示
　されるようにしてください。
・カテゴリー引数は taxonomies の id を取るように実装してください
・実際のパスは /potepan/categories/:taxon_id/ となります。

## Task 4
・課題２で作成した商品ページのページ下部に表示している商品と同じカテゴリーに属する商品が表示されるように実装してください。

## Task 5
本Taskよりコードレビューはいただいておりません。masterへはmergeさせておらず、別途Task5ブランチとしてpushしてあります。
・トップページ（/potepan）にテンプレート（potepan/sample/index.html.erb）を使用して新着商品が表示される実装をしてください
・パスは /potepan/ です。
・新着商品の定義は Available On の新着とします。
・app/views/layouts/application.html.erb を使用して、ヘッダーの共通化を行ってください。
