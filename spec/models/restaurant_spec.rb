require 'rails_helper'

RSpec.describe Restaurant, type: :model do

  describe "バリデーションのテスト" do
    let(:area) { create(:area) }
    let(:restaurant_type) { create(:restaurant_type) }

    describe "全ての項目" do
      context "入力時" do
        it "有効であること" do
          restaurant = build(:restaurant,
                             area: area,
                             restaurant_type: restaurant_type)
          expect(restaurant).to be_valid
        end
      end
    end

    describe "name" do
      context "ない場合" do
        it "無効であること" do
          restaurant = build(:restaurant,
                             area: area,
                             restaurant_type: restaurant_type,
                             name: nil)
          restaurant.valid?
          expect(restaurant.errors[:name]).to include("が入力されていません。")
        end
      end

      context "重複している場合" do
        it "無効であること" do
          restaurant1 = create(:restaurant,
                               area: area,
                               restaurant_type: restaurant_type)
          restaurant2 = build(:restaurant,
                              area: area,
                              restaurant_type: restaurant_type,
                              name: restaurant1.name)
          restaurant2.valid?
          expect(restaurant2.errors[:name]).to include("はすでに存在します。")
        end
      end
    end

    describe "tel" do
      context "ない場合" do
        it "無効であること" do
          restaurant = build(:restaurant,
                             area: area,
                             restaurant_type: restaurant_type,
                             tel: nil)
          restaurant.valid?
          expect(restaurant.errors[:tel]).to include("が入力されていません。")
        end
      end
    end

    describe "url" do
      context "ない場合" do
        it "有効であること" do
          restaurant = build(:restaurant,
                             area: area,
                             restaurant_type: restaurant_type,
                             url: nil)
          expect(restaurant).to be_valid
        end
      end
    end

    describe "address" do
      context "ない場合" do
        it "無効であること" do
          restaurant = build(:restaurant,
                             area: area,
                             restaurant_type: restaurant_type,
                             address: nil)
          restaurant.valid?
          expect(restaurant.errors[:address]).to include("が入力されていません。")
        end
      end

      context "長崎県でない場合" do
        it "無効であること" do
          restaurant = build(:restaurant,
                             area: area,
                             restaurant_type: restaurant_type,
                             address: "長崎市")
          restaurant.valid?
          expect(restaurant.errors[:address]).to include("に長崎県以外が設定されています。")
        end
      end
    end

    describe "tel" do
      context "9桁以下の場合" do
        it "無効であること" do
          restaurant = build(:restaurant,
                             area: area,
                             restaurant_type: restaurant_type,
                             tel: "0" * 9)
          restaurant.valid?
          expect(restaurant.errors[:tel]).to include("は有効でありません。")
        end
      end

      context "12桁以上の場合" do
        it "無効であること" do
          restaurant = build(:restaurant,
                             area: area,
                             restaurant_type: restaurant_type,
                             tel: "0" * 12)
          restaurant.valid?
          expect(restaurant.errors[:tel]).to include("は有効でありません。")
        end
      end

      context "重複している場合" do
        it "電話番号が重複しているとき無効であること" do
          restaurant1 = create(:restaurant,
                               area: area,
                               restaurant_type: restaurant_type)
          restaurant2 = build(:restaurant,
                              area: area,
                              restaurant_type: restaurant_type,
                              tel: restaurant1.tel)
          restaurant2.valid?
          expect(restaurant2.errors[:tel]).to include("はすでに存在します。")
        end
      end
    end
  end

  describe "scopのテスト" do

    describe "お店の名前のテスト" do
      let(:restaurant1) { create(:restaurant) }
      let(:restaurant2) { create(:restaurant, name: "TestCafe") }
      let(:restaurant3) { create(:restaurant, name: "ShopBakery") }

      context "名前が一致する場合" do
        it "一致する名前のお店のデータを返すこと" do
          expect(Restaurant.search(name: "Shop")).to include(restaurant1, restaurant3)
          expect(Restaurant.search(name: "Shop")).to_not include(restaurant2)
        end
      end

      context "名前が一致しない場合" do
        it "空のコレクションを返すこと" do
          expect(Restaurant.search(name: "bar")).to be_empty
        end
      end
    end

    describe "お気に入りのテスト" do
      let!(:restaurant1) { create(:restaurant) }
      let!(:post1) { create(:post, restaurant: restaurant1, likes: true) }
      let!(:restaurant2) { create(:restaurant) }
      let!(:post2) { create(:post, restaurant: restaurant2, likes: false)}

      context "お気に入りのチェックがある場合" do
        it "お気に入りのデータのみ返すこと" do
          expect(Restaurant.includes(:posts).search(likes: "1")).to include(restaurant1)
          expect(Restaurant.includes(:posts).search(likes: "1")).to_not include(restaurant2)
        end
      end

      context "お気に入りのチェックがない場合" do
        it "全てのデータを返すこと" do
          expect(Restaurant.includes(:posts).search(likes: "0")).to include(restaurant1, restaurant2)
        end
      end
    end

    describe "イマイチのテスト" do
      let!(:restaurant1) { create(:restaurant) }
      let!(:post1) { create(:post, restaurant: restaurant1, dislikes: true) }
      let!(:restaurant2) { create(:restaurant) }
      let!(:post2) { create(:post, restaurant: restaurant2, dislikes: false)}

      context "イマイチのチェックがある場合" do
        it "イマイチのデータのみ返すこと" do
          expect(Restaurant.includes(:posts).search(dislikes: "1")).to include(restaurant1)
          expect(Restaurant.includes(:posts).search(dislikes: "1")).to_not include(restaurant2)
        end
      end

      context "イマイチのデータがない場合" do
        it "全てのデータを返すこと" do
          expect(Restaurant.includes(:posts).search(dislikes: "0")).to include(restaurant1, restaurant2)
        end
      end
    end

    describe "エリア選択のテスト" do
      let(:restaurant1) { create(:restaurant) }
      let(:restaurant2) { create(:restaurant) }

      context "エリアを選択した場合" do
        it "選択されたエリアのデータが返ること" do
          expect(Restaurant.search(area_id: restaurant1.area_id)).to include(restaurant1)
          expect(Restaurant.search(area_id: restaurant1.area_id)).to_not include(restaurant2)
        end
      end

      context "エリアを選択していない場合" do
        it "全てのデータを返すこと" do
          expect(Restaurant.search(area_id: nil)).to include(restaurant1, restaurant2)
        end
      end
    end

    describe "ジャンル選択のテスト" do
      let(:restaurant1) { create(:restaurant) }
      let(:restaurant2) { create(:restaurant) }

      context "ジャンルを選択した場合" do
        it "選択されたジャンルのデータが返ること" do
          expect(Restaurant.search(restaurant_type_id: restaurant1.restaurant_type_id)).to include(restaurant1)
          expect(Restaurant.search(restaurant_type_id: restaurant1.restaurant_type_id)).to_not include(restaurant2)
        end
      end

      context "ジャンルを選択していない場合" do
        it "全てのデータを返すこと" do
          expect(Restaurant.search(restaurant_type_id: nil)).to include(restaurant1, restaurant2)
        end
      end
    end

    # describe "評価順" do
    #
    #   # post1 = build(:post, atmosphere: 2, comment: "1番")
    #   # post1.valid?
    #   #
    #   post1 = create(:post)
    #   post2 = create(:post)
    #   post3 = create(:post)
    #
    #   # post1 = create(:post, atmosphere: 2, comment:"1番")
    #   # post2 = create(:post, atmosphere: 3, comment:"2番")
    #   # post3 = create(:post, atmosphere: 4, comment:"3番")
    #
    #   expect(Restaurant.search(order: 0).map(&:comment)).to eq["1番","2番","3番"]
    # end
    # it "評価順" do
    #   post1 = create(:post, atmosphere: 2)
    #   post2 = create(:post, atmosphere: 3)
    #   post3 = create(:post, atmosphere: 4)
    # end

  end
end
