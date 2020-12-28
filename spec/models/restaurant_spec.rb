require 'rails_helper'

RSpec.describe Restaurant, type: :model do

  # describe "バリデーションのテスト" do
  #   before do
  #     @area = FactoryBot.create(:area)
  #     @restaurant_type = FactoryBot.create(:restaurant_type)
  #   end
  #
  #   it "すべての項目入力時有効であること" do
  #     restaurant = FactoryBot.build(:restaurant,
  #                                   area: @area,
  #                                   restaurant_type: @restaurant_type)
  #     expect(restaurant).to be_valid
  #   end
  #
  #   it "すべての項目入力時有効であること" do
  #     restaurant = FactoryBot.build(:restaurant,
  #                                   area: @area,
  #                                   restaurant_type: @restaurant_type)
  #     expect(restaurant).to be_valid
  #   end
  #
  #   it "名前が無い場合無効であること" do
  #     restaurant = FactoryBot.build(:restaurant,
  #                                   area: @area,
  #                                   restaurant_type: @restaurant_type,
  #                                   name: nil)
  #     restaurant.valid?
  #     expect(restaurant.errors[:name]).to include("が入力されていません。")
  #   end
  #
  #   it "名前が重複しているとき無効であること" do
  #     restaurant1 = FactoryBot.create(:restaurant,
  #                                     area: @area,
  #                                     restaurant_type: @restaurant_type)
  #     restaurant2 = FactoryBot.build(:restaurant,
  #                                    area: @area,
  #                                    restaurant_type: @restaurant_type,
  #                                    name: restaurant1.name)
  #     restaurant2.valid?
  #     expect(restaurant2.errors[:name]).to include("はすでに存在します。")
  #   end
  #
  #   it "電話番号が無い場合無効であること" do
  #     restaurant = FactoryBot.build(:restaurant,
  #                                   area: @area,
  #                                   restaurant_type: @restaurant_type,
  #                                   tel: nil)
  #     restaurant.valid?
  #     expect(restaurant.errors[:tel]).to include("が入力されていません。")
  #   end
  #
  #   it "URLが無い場合有効であること" do
  #     restaurant = FactoryBot.build(:restaurant,
  #                                   area: @area,
  #                                   restaurant_type: @restaurant_type,
  #                                   url: nil)
  #     expect(restaurant).to be_valid
  #   end
  #
  #   it "住所が無い場合無効であること" do
  #     restaurant = FactoryBot.build(:restaurant,
  #                                   area: @area,
  #                                   restaurant_type: @restaurant_type,
  #                                   address: nil)
  #     restaurant.valid?
  #     expect(restaurant.errors[:address]).to include("が入力されていません。")
  #   end
  #
  #   it "住所に長崎県が無い場合無効であること" do
  #     restaurant = FactoryBot.build(:restaurant,
  #                                   area: @area,
  #                                   restaurant_type: @restaurant_type,
  #                                   address: "長崎市")
  #     restaurant.valid?
  #     expect(restaurant.errors[:address]).to include("に長崎県以外が設定されています。")
  #   end
  #
  #   it "電話番号の桁数が少ない(9桁以下)場合無効であること" do
  #     restaurant = FactoryBot.build(:restaurant,
  #                                   area: @area,
  #                                   restaurant_type: @restaurant_type,
  #                                   tel: "0" * 9)
  #     restaurant.valid?
  #     expect(restaurant.errors[:tel]).to include("は有効でありません。")
  #   end
  #
  #   it "電話番号の桁数が多い(12桁以上)場合無効であること" do
  #     restaurant = FactoryBot.build(:restaurant,
  #                                   area: @area,
  #                                   restaurant_type: @restaurant_type,
  #                                   tel: "0" * 12)
  #     restaurant.valid?
  #     expect(restaurant.errors[:tel]).to include("は有効でありません。")
  #   end
  #
  #   it "電話番号が重複しているとき無効であること" do
  #     restaurant1 = FactoryBot.create(:restaurant,
  #                                     area: @area,
  #                                     restaurant_type: @restaurant_type)
  #     restaurant2 = FactoryBot.build(:restaurant,
  #                                    area: @area,
  #                                    restaurant_type: @restaurant_type,
  #                                    tel: restaurant1.tel)
  #     restaurant2.valid?
  #     expect(restaurant2.errors[:tel]).to include("はすでに存在します。")
  #   end
  # end

  describe "scopのテスト" do

    # describe "お店の名前のテスト" do
    #   let(:restaurant1) { FactoryBot.create(:restaurant) }
    #   let(:restaurant2) { FactoryBot.create(:restaurant,name: "TestCafe") }
    #   let(:restaurant3) { FactoryBot.create(:restaurant,name: "ShopBakery")}
    #
    #   it "お店の名前で一致するお店を返すこと" do
    #     expect(Restaurant.search(name: "Shop")).to include(restaurant1,restaurant3)
    #     expect(Restaurant.search(name: "Shop")).to_not include(restaurant2)
    #   end
    #
    #   it "お店の名前で一致しない場合空のコレクションを返すこと" do
    #     expect(Restaurant.search(name: "bar")).to be_empty
    #   end
    # end

    describe "評価順" do

      # post1 = FactoryBot.build(:post, atmosphere: 2, comment: "1番")
      # post1.valid?
      #
      post1 = FactoryBot.create(:post)
      post2 = FactoryBot.create(:post)
      post3 = FactoryBot.create(:post)

      # post1 = FactoryBot.create(:post, atmosphere: 2, comment:"1番")
      # post2 = FactoryBot.create(:post, atmosphere: 3, comment:"2番")
      # post3 = FactoryBot.create(:post, atmosphere: 4, comment:"3番")

      expect(Restaurant.search(order: 0).map(&:comment)).to eq["1番","2番","3番"]
    end
    # it "評価順" do
    #   post1 = FactoryBot.create(:post, atmosphere: 2)
    #   post2 = FactoryBot.create(:post, atmosphere: 3)
    #   post3 = FactoryBot.create(:post, atmosphere: 4)
    # end

  end
end
