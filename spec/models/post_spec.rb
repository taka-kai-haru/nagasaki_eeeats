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
          expect(post2.errors[:user_id]).to include("レコードが重複しています。")
        end
      end
    end
  end
end
