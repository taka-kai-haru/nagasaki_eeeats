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

#Payment_methodsテーブル
PaymentMethod.create!(name: "JCB", save_location: "jcb.png", order: 1)
PaymentMethod.create!(name: "Visa", save_location: "visa.png", order: 2)
PaymentMethod.create!(name: "Master", save_location: "master.png", order: 3)
PaymentMethod.create!(name: "Amex", save_location: "amex.png", order: 4)
PaymentMethod.create!(name: "Diners Club", save_location: "diners_club.png", order: 5)
PaymentMethod.create!(name: "Union Pay", save_location: "union_pay.png", order: 6)
PaymentMethod.create!(name: "Discover", save_location: "discover.png", order: 7)
PaymentMethod.create!(name: "PayPay", save_location: "pay_pay.png", order: 8)
PaymentMethod.create!(name: "Rakten Pay", save_location: "rakten_pay.png", order: 9)
PaymentMethod.create!(name: "D払い", save_location: "d_pay.png", order: 10)
PaymentMethod.create!(name: "Line Pay.png", save_location: "line_pay.png", order: 11)
PaymentMethod.create!(name: "Meru Pay.png", save_location: "meru_pay.png", order: 12)
PaymentMethod.create!(name: "Quick Pay", save_location: "quick_pay.png", order: 13)
PaymentMethod.create!(name: "Au Pay", save_location: "au_pay.png", order: 14)
PaymentMethod.create!(name: "Air Pay", save_location: "air_pay.png", order: 15)
PaymentMethod.create!(name: "Ali Pay", save_location: "ali_pay.png", order: 16)
PaymentMethod.create!(name: "Apple Pay", save_location: "apple_pay.png", order: 17)
PaymentMethod.create!(name: "ID", save_location: "id.png", order: 18)
PaymentMethod.create!(name: "Wechat pay", save_location: "wechat_pay.png", order: 19)
