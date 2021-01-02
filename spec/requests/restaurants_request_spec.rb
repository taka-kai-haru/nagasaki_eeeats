require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  let(:name) { describe "get#show" do
    let(:user) { create(:user) }
    let(:restaurant) { create(:restaurant) }
    context "ログイン後の場合" do
      it "正常にレスポンスを返すこと" do
        user.confirm
        sign_in user
        get restaurant_path restaurant.id
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end
    context "未ログインの場合" do
      it "ログイン画面へ画面遷移するとこ" do
        get restaurant_path restaurant.id
        expect(response).to_not be_successful
        expect(response).to redirect_to new_user_session_path
      end
    end
  end }

  describe "get#index" do
    let(:user) { create(:user) }
    context "ログイン後の場合" do
      it "正常にレスポンスを返すこと" do
        user.confirm
        sign_in user
        get restaurants_path
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end
    context "未ログインの場合" do
      it "ログイン画面へ画面遷移するとこ" do
        get restaurants_path
        expect(response).to_not be_successful
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "get#new" do
    let(:user) { create(:user) }
    context "ログイン後の場合" do
      it "正常にレスポンスを返すこと" do
        user.confirm
        sign_in user
        get new_restaurant_path
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end
    context "未ログインの場合" do
      it "ログイン画面へ画面遷移するとこ" do
        get new_restaurant_path
        expect(response).to_not be_successful
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "get#edit" do
    let(:user) { create(:user) }
    let(:restaurant) { create(:restaurant) }
    context "ログイン後の場合" do
      it "正常にレスポンスを返すこと" do
        user.confirm
        sign_in user
        get edit_restaurant_path restaurant.id
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end
    context "未ログインの場合" do
      it "ログイン画面へ画面遷移するとこ" do
        get edit_restaurant_path restaurant.id
        expect(response).to_not be_successful
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "post#new" do
    let(:user) { create(:user) }
    let(:restaurant_type) { create(:restaurant_type) }
    let(:area) { create(:area) }
    let(:restaurant_params) { attributes_for(:restaurant, restaurant_type_id: restaurant_type.id, area_id: area.id) }
    let(:invalid_restaurant_params) { attributes_for(:restaurant, name: nil, restaurant_type_id: restaurant_type.id, area_id: area.id,) }

    context 'パラメータが妥当な場合' do
      context "ログイン済の場合" do
        before do
          user.confirm
          sign_in user
        end
        it 'リクエストが成功すること' do
          post restaurants_path, params: { restaurant: restaurant_params }
          expect(response).to have_http_status(302)
        end

        it 'お店のデータが登録されること' do
          expect do
            post restaurants_path, params: { restaurant: restaurant_params }
          end.to change(Restaurant, :count).by(1)
        end

        it 'リダイレクトすること' do
          post restaurants_path, params: { restaurant: restaurant_params }
          expect(response).to redirect_to new_post_path(restaurant_id: Restaurant.last.id)
        end
      end

      context "未ログインの場合" do
        it "ログイン画面へ画面遷移するとこ" do
          post restaurants_path, params: { restaurant: restaurant_params }
          expect(response).to redirect_to new_user_session_path
        end

        it "お店のデータが登録されないこと" do
          expect do
            post restaurants_path, params: { restaurant: restaurant_params }
          end.to_not change(Restaurant, :count)
        end
      end
    end

    context 'パラメータが不正な場合' do
      context "ログイン済の場合" do
        before do
          user.confirm
          sign_in user
        end
        it 'リクエストが成功すること' do
          post restaurants_path, params: { restaurant: invalid_restaurant_params }
          expect(response).to have_http_status(200)
        end

        it 'お店のデータが登録されないこと' do
          expect do
            post restaurants_path, params: { restaurant: invalid_restaurant_params }
          end.to_not change(Restaurant, :count)
        end

        it 'newテンプレートで表示されること' do
          post restaurants_path, params: { restaurant: invalid_restaurant_params }
          expect(response).to render_template :new
        end

        it 'エラーが表示されること' do
          post restaurants_path, params: { restaurant: invalid_restaurant_params }
          expect(assigns(:restaurant).errors.any?).to be_truthy
        end
      end

      context "未ログインの場合" do
        it "ログイン画面へ画面遷移するとこ" do
          post restaurants_path, params: { restaurant: invalid_restaurant_params }
          expect(response).to redirect_to new_user_session_path
        end

        it "お店のデータが登録されないこと" do
          expect do
            post restaurants_path, params: { restaurant: invalid_restaurant_params }
          end.to_not change(Restaurant, :count)
        end
      end
    end
  end

  describe "post#edit" do
    let(:user) { create(:user) }
    let(:restaurant) { create(:restaurant) }
    let(:restaurant_update_params) { attributes_for(:restaurant, name: "TestShop", area_id: restaurant.area.id, restaurant_type_id: restaurant.restaurant_type.id) }
    let(:invalid_restaurant_update_params) { attributes_for(:restaurant, name: nil, area_id: restaurant.area.id, restaurant_type_id: restaurant.restaurant_type.id) }

    context 'パラメータが妥当な場合' do
      context "ログイン済の場合" do
        before do
          user.confirm
          sign_in user
        end
        it 'リクエストが成功すること' do
          put restaurant_path restaurant, params: { restaurant: restaurant_update_params }
          expect(response).to have_http_status(302)
        end

        it 'お店のデータが更新されること' do
          expect do
            put restaurant_path restaurant, params: { restaurant: restaurant_update_params }
          end.to change { Restaurant.find(restaurant.id).name }.from(restaurant.name).to('TestShop')
        end

        it 'リダイレクトすること' do
          put restaurant_path restaurant, params: { restaurant: restaurant_update_params }
          expect(response).to redirect_to restaurant_path restaurant
        end
      end
      context "未ログインの場合" do
        it "ログイン画面へ画面遷移するとこ" do
          put restaurant_path restaurant, params: { restaurant: restaurant_update_params }
          expect(response).to redirect_to new_user_session_path
        end

        it "お店のデータが更新されないこと" do
          expect do
            put restaurant_path restaurant, params: { restaurant: restaurant_update_params }
          end.to_not change(Restaurant.find(restaurant.id), :name)
        end
      end
    end

    context 'パラメータが不正な場合' do
      context "ログイン済の場合" do
        before do
          user.confirm
          sign_in user
        end
        it 'リクエストが成功すること' do
          put restaurant_path restaurant, params: { restaurant: invalid_restaurant_update_params }
          expect(response).to have_http_status(200)
        end

        it 'お店のデータが更新されないこと' do
          expect do
            put restaurant_path restaurant, params: { restaurant: invalid_restaurant_update_params }
          end.to_not change(Restaurant.find(restaurant.id), :name)
        end

        it 'editテンプレートで表示されること' do
          put restaurant_path restaurant, params: { restaurant: invalid_restaurant_update_params }
          expect(response).to render_template :edit
        end

        it 'エラーが表示されること' do
          put restaurant_path restaurant, params: { restaurant: invalid_restaurant_update_params }
          expect(assigns(:restaurant).errors.any?).to be_truthy
        end
      end
      context "未ログインの場合" do
        it "ログイン画面へ画面遷移するとこ" do
          put restaurant_path restaurant, params: { restaurant: invalid_restaurant_update_params }
          expect(response).to redirect_to new_user_session_path
        end

        it "お店のデータが更新されないこと" do
          expect do
            put restaurant_path restaurant, params: { restaurant: invalid_restaurant_update_params }
          end.to_not change(Restaurant.find(restaurant.id), :name)
        end
      end
    end
  end

  describe 'DELETE #destroy' do

    context "管理者ユーザの場合" do
      let!(:admin_user) { create(:user,:admin) }
      let!(:restaurant) { create :restaurant }
      let!(:user) {create(:user)}
      let!(:restaurant_add_post) { create :restaurant }
      let!(:post) {create :post, restaurant: restaurant_add_post, user: user}

      context "ログイン済の場合" do
        before do
          admin_user.confirm
          sign_in admin_user
        end

        it 'リクエストが成功すること' do
          delete restaurant_path restaurant
          expect(response).to have_http_status(302)
        end

        it 'お店のデータが削除されること' do
          expect do
            delete restaurant_path restaurant
          end.to change(Restaurant, :count).by(-1)
        end

        it '他の人のコメントがあるお店のデータが削除されること' do
          expect do
            delete restaurant_path restaurant_add_post
          end.to change(Restaurant, :count).by(-1)
        end

        it 'お店の一覧にリダイレクトすること' do
          delete restaurant_path restaurant
          expect(response).to redirect_to restaurants_path
        end
      end

      context "未ログインの場合" do
        it "ログイン画面へ画面遷移するとこ" do
          delete restaurant_path restaurant
          expect(response).to redirect_to new_user_session_path
        end

        it "お店のデータが削除されないこと" do
          expect do
            delete restaurant_path restaurant
          end.to change(Restaurant, :count).by(0)
        end
      end
    end

    context "一般ユーザの場合" do
      let!(:user) { create(:user) }
      let!(:restaurant) { create :restaurant }
      let!(:other_user) {create(:user)}
      let!(:restaurant_add_post) { create :restaurant }
      let!(:post) {create :post, restaurant: restaurant_add_post, user: other_user}

      context "ログイン済の場合" do
        before do
          user.confirm
          sign_in user
        end

        context "他の人のコメントがある場合" do
          it 'お店のデータが削除されないこと' do
            expect do
              delete restaurant_path restaurant_add_post
            end.to change(Restaurant, :count).by(0)
          end

          it 'お店の一覧にリダイレクトすること' do
            delete restaurant_path restaurant_add_post
            expect(response).to render_template :show
          end
        end

        context "他の人のコメントがない場合" do
          it 'リクエストが成功すること' do
            delete restaurant_path restaurant
            expect(response).to have_http_status(302)
          end

          it 'お店のデータが削除されること' do
            expect do
              delete restaurant_path restaurant
            end.to change(Restaurant, :count).by(-1)
          end

          it 'お店の一覧にリダイレクトすること' do
            delete restaurant_path restaurant
            expect(response).to redirect_to restaurants_path
          end
        end
      end

      context "未ログインの場合" do
        it "ログイン画面へ画面遷移するとこ" do
          delete restaurant_path restaurant
          expect(response).to redirect_to new_user_session_path
        end

        it "お店のデータが削除されないこと" do
          expect do
            delete restaurant_path restaurant
          end.to change(Restaurant, :count).by(0)
        end
      end
    end

  end
end
