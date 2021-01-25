require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "バリデーションのテスト" do
    let(:restaurant) { create(:restaurant) }
    let(:user) { create(:user) }

    describe "全ての項目" do
      context "入力時" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user)
          expect(post).to be_valid
        end
      end
    end

    describe "delicious" do
      context "0の場合" do
        it "無効であること" do
          post = build(:post, restaurant: restaurant, user: user, delicious: 0)
          expect(post).to_not be_valid
        end
      end

      context "1の場合" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user, delicious: 1)
          expect(post).to be_valid
        end
      end

      context "5の場合" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user, delicious: 5)
          expect(post).to be_valid
        end
      end

      context "6の場合" do
        it "無効であること" do
          post = build(:post, restaurant: restaurant, user: user, delicious: 6)
          expect(post).to_not be_valid
        end
      end
    end

    describe "atmosphere" do
      context "0の場合" do
        it "無効であること" do
          post = build(:post, restaurant: restaurant, user: user, atmosphere: 0)
          expect(post).to_not be_valid
        end
      end

      context "1の場合" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user, atmosphere: 1)
          expect(post).to be_valid
        end
      end

      context "5の場合" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user, atmosphere: 5)
          expect(post).to be_valid
        end
      end

      context "6の場合" do
        it "無効であること" do
          post = build(:post, restaurant: restaurant, user: user, atmosphere: 6)
          expect(post).to_not be_valid
        end
      end
    end

    describe "accessibility" do
      context "0の場合" do
        it "無効であること" do
          post = build(:post, restaurant: restaurant, user: user, accessibility: 0)
          expect(post).to_not be_valid
        end
      end

      context "1の場合" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user, accessibility: 1)
          expect(post).to be_valid
        end
      end

      context "5の場合" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user, accessibility: 5)
          expect(post).to be_valid
        end
      end

      context "6の場合" do
        it "無効であること" do
          post = build(:post, restaurant: restaurant, user: user, accessibility: 6)
          expect(post).to_not be_valid
        end
      end
    end

    describe "cost_performance" do
      context "0の場合" do
        it "無効であること" do
          post = build(:post, restaurant: restaurant, user: user, cost_performance: 0)
          expect(post).to_not be_valid
        end
      end

      context "1の場合" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user, cost_performance: 1)
          expect(post).to be_valid
        end
      end

      context "5の場合" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user, cost_performance: 5)
          expect(post).to be_valid
        end
      end

      context "6の場合" do
        it "無効であること" do
          post = build(:post, restaurant: restaurant, user: user, cost_performance: 6)
          expect(post).to_not be_valid
        end
      end
    end

    describe "assortment" do
      context "0の場合" do
        it "無効であること" do
          post = build(:post, restaurant: restaurant, user: user, assortment: 0)
          expect(post).to_not be_valid
        end
      end

      context "1の場合" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user, assortment: 1)
          expect(post).to be_valid
        end
      end

      context "5の場合" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user, assortment: 5)
          expect(post).to be_valid
        end
      end

      context "6の場合" do
        it "無効であること" do
          post = build(:post, restaurant: restaurant, user: user, assortment: 6)
          expect(post).to_not be_valid
        end
      end
    end

    describe "service" do
      context "0の場合" do
        it "無効であること" do
          post = build(:post, restaurant: restaurant, user: user, service: 0)
          expect(post).to_not be_valid
        end
      end

      context "1の場合" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user, service: 1)
          expect(post).to be_valid
        end
      end

      context "5の場合" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user, service: 5)
          expect(post).to be_valid
        end
      end

      context "6の場合" do
        it "無効であること" do
          post = build(:post, restaurant: restaurant, user: user, service: 6)
          expect(post).to_not be_valid
        end
      end
    end

    describe "comment" do
      context "ない場合" do
        it "有効であること" do
          post = build(:post, restaurant: restaurant, user: user, comment: "")
          expect(post).to be_valid
        end
      end
    end

    describe "user" do
      context "同じユーザが登録した場合" do
        it "無効であること" do
          # post1 = create(:post) -> before do でcreate された restaurant/userを更にcreateする為エラーとなる
          post1 = create(:post, restaurant: restaurant, user: user)
          post2 = build(:post, restaurant: restaurant, user: user)
          post2.valid?
          expect(post2.errors[:restaurant_id]).to include("レコードが重複しています。")
        end
      end
    end
  end
end
