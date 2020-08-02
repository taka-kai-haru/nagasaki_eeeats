# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Prefectureテーブル
Prefecture.create!(name: "長崎県")

#areasテーブル
Prefecture.all.each do |prefecture|
  prefecture.areas.create!(areas_name: "長崎市")
  prefecture.areas.create!(areas_name: "佐世保市")
  prefecture.areas.create!(areas_name: "時津・長与・西海")
  prefecture.areas.create!(areas_name: "大村・諫早")
  prefecture.areas.create!(areas_name: "雲仙・島原・南島原")
  prefecture.areas.create!(areas_name: "平戸・松浦")
  prefecture.areas.create!(areas_name: "波佐見・川棚")
  prefecture.areas.create!(areas_name: "五島・壱岐・対馬")
end

#RestaurantTypeテーブル
RestaurantType.create!(name: "居酒屋")
RestaurantType.create!(name: "和食")
RestaurantType.create!(name: "寿司")
RestaurantType.create!(name: "焼肉・ホルモン・鉄板焼き")
RestaurantType.create!(name: "イタリアン・フレンチ")
RestaurantType.create!(name: "バイキング")
RestaurantType.create!(name: "カレー")
RestaurantType.create!(name: "中華料理")
RestaurantType.create!(name: "洋食・西洋料理")
RestaurantType.create!(name: "アジア・エスニック料理")
RestaurantType.create!(name: "ラーメン・うどん・そば")
RestaurantType.create!(name: "バー")
RestaurantType.create!(name: "カフェ")
RestaurantType.create!(name: "その他料理")