require 'rails_helper'

RSpec.describe Post, type: :model do
  # before do
  #   @restaurant = FactoryBot.create(:restaurant)
  #   @user = FactoryBot.create(:user)
  # end
  #
  # it "すべての項目入力時有効であること" do
  #   post = FactoryBot.build(:post, restaurant: @restaurant, user: @user)
  #   expect(post).to be_valid
  # end
  #
  # it "コメントが無い時有効であること" do
  #   post = FactoryBot.build(:post, restaurant: @restaurant, user: @user, comment: "")
  #   expect(post).to be_valid
  # end
  #
  # it "同じユーザーが登録した場合無効であること" do
  #   # post1 = FactoryBot.create(:post) -> before do でcreate された restaurant/userを更にcreateする為エラーとなる
  #   post1 = FactoryBot.create(:post, restaurant: @restaurant, user: @user)
  #   post2 = FactoryBot.build(:post, restaurant: @restaurant, user: @user)
  #   post2.valid?
  #   expect(post2.errors[:user_id]).to include("レコードが重複しています。")
  # end

end
