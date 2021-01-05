require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "get#show" do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    context "ログイン後の場合" do
      it "正常にレスポンスを返すこと" do
        user.confirm
        sign_in user
        get post_path post
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    context "未ログインの場合" do
      it "ログイン画面へ画面遷移するとこ" do
        get post_path post
        expect(response).to_not be_successful
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "get#new" do
    let(:user) { create(:user) }
    let(:restaurant) { create(:restaurant) }

    context "ログイン後の場合" do
      it "正常にレスポンスを返すこと" do
        user.confirm
        sign_in user
        get new_post_path(restaurant_id: restaurant.id)
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    context "未ログインの場合" do
      it "ログイン画面へ画面遷移するとこ" do
        get new_post_path(restaurant_id: restaurant.id)
        expect(response).to_not be_successful
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "get#edit" do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    context "ログイン後の場合" do
      it "正常にレスポンスを返すこと" do
        user.confirm
        sign_in user
        get edit_post_path post
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    context "未ログインの場合" do
      it "ログイン画面へ画面遷移するとこ" do
        get edit_post_path post
        expect(response).to_not be_successful
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "post#new" do
    let(:user) { create(:user) }
    let(:restaurant) { create(:restaurant) }
    let(:post_params) { attributes_for(:post, restaurant_id: restaurant.id, user_id: user.id) }
    let(:invalid_post_params) { attributes_for(:post, accessibility: 0, restaurant_id: restaurant.id, user_id: user.id) }

    context 'パラメータが妥当な場合' do
      context "ログイン済の場合" do
        before do
          user.confirm
          sign_in user
        end
        it 'リクエストが成功すること' do
          post posts_path, params: { post: post_params }
          expect(response).to have_http_status(302)
        end
        it 'コメントのデータが登録されること' do
          expect do
            post posts_path, params: { post: post_params }
          end.to change(Post, :count).by(1)
        end
        it 'リダイレクトすること' do
          post posts_path, params: { post: post_params }
          expect(response).to redirect_to restaurant_path restaurant
        end
      end

      context "未ログインの場合" do
        it "ログイン画面へ画面遷移するとこ" do
          post posts_path, params: { post: post_params }
          expect(response).to redirect_to new_user_session_path
        end
        it "コメントのデータが登録されないこと" do
          expect do
            post posts_path, params: { post: post_params }
          end.to_not change(Post, :count)
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
          post posts_path, params: { post: invalid_post_params }
          expect(response).to have_http_status(200)
        end
        it 'コメントのデータが登録されないこと' do
          expect do
            post posts_path, params: { post: invalid_post_params }
          end.to_not change(Post, :count)
        end
        it 'newテンプレートで表示されること' do
          post posts_path, params: { post: invalid_post_params }
          expect(response).to render_template :new
        end
        it 'エラーが表示されること' do
          post posts_path, params: { post: invalid_post_params }
          expect(assigns(:post).errors.any?).to be_truthy
        end
      end

      context "未ログインの場合" do
        it "ログイン画面へ画面遷移するとこ" do
          post posts_path, params: { post: invalid_post_params }
          expect(response).to redirect_to new_user_session_path
        end
        it "コメントのデータが登録されないこと" do
          expect do
            post posts_path, params: { post: invalid_post_params }
          end.to_not change(Post, :count)
        end
      end
    end
  end

  describe "post#edit" do
    let(:user) { create(:user) }
    let(:post) { create(:post,user_id: user.id) }
    let(:post_update_params) { attributes_for(:post, accessibility: 1, restaurant_id: post.restaurant_id, user_id: post.user_id) }
    let(:invalid_post_update_params) { attributes_for(:post, accessibility: 0, restaurant_id: post.restaurant_id, user_id: post.user_id) }
    let(:other_user) { create(:user) }
    let(:other_restaurant) { create(:restaurant) }
    let(:invalid_restaurant_post_update_params) { attributes_for(:post, accessibility: 0, restaurant_id: other_restaurant.id) }

    context 'パラメータが妥当な場合' do
      context "ログイン済の場合" do
        before do
          user.confirm
          sign_in user
        end
        it 'リクエストが成功すること' do
          put post_path post, params: { post: post_update_params }
          expect(response).to have_http_status(302)
        end
        it 'コメントのデータが更新されること' do
          expect do
            put post_path post, params: { post: post_update_params }
          end.to change { Post.find(post.id).accessibility }.from(post.accessibility).to(1)
        end
        it 'リダイレクトすること' do
          put post_path post, params: { post: post_update_params }
          expect(response).to redirect_to restaurant_path post.restaurant
        end
      end

      context "未ログインの場合" do
        it "ログイン画面へ画面遷移するとこ" do
          put post_path post, params: { post: post_update_params }
          expect(response).to redirect_to new_user_session_path
        end
        it "コメントのデータが更新されないこと" do
          expect do
            put post_path post, params: { post: post_update_params }
          end.to_not change(Post.find(post.id), :accessibility)
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
          put post_path post, params: { post: invalid_post_update_params }
          expect(response).to have_http_status(200)
        end
        it 'コメントのデータが更新されないこと' do
          expect do
            put post_path post, params: { post: invalid_post_update_params }
          end.to_not change(Post.find(post.id), :accessibility)
        end
        it 'editテンプレートで表示されること' do
          put post_path post, params: { post: invalid_post_update_params }
          expect(response).to render_template :edit
        end
        it 'エラーが表示されること' do
          put post_path post, params: { post: invalid_post_update_params }
          expect(assigns(:post).errors.any?).to be_truthy
        end
      end

      context "未ログインの場合" do
        it "ログイン画面へ画面遷移するとこ" do
          put post_path post, params: { post: invalid_post_update_params }
          expect(response).to redirect_to new_user_session_path
        end
        it "コメントのデータが更新されないこと" do
          expect do
            put post_path post, params: { post: invalid_post_update_params }
          end.to_not change(Post.find(post.id), :accessibility)
        end
      end

      context "異なるユーザーが更新しようとする場合" do
        before do
          other_user.confirm
          sign_in other_user
        end
        it 'コメントのデータが更新されないこと' do
          expect do
            put post_path post, params: { post: invalid_post_update_params }
          end.to_not change(Post.find(post.id), :accessibility)
        end
        it 'editテンプレートで表示されること' do
          put post_path post, params: { post: invalid_post_update_params }
          expect(response).to render_template :edit
        end
      end

      context "異なるお店を更新しようとする場合" do
        before do
          user.confirm
          sign_in user
        end
        it 'コメントのデータが更新されないこと' do
          expect do
            put post_path post, params: { post: invalid_restaurant_post_update_params }
          end.to_not change(Post.find(post.id), :accessibility)
        end
        it 'editテンプレートで表示されること' do
          put post_path post, params: { post: invalid_restaurant_post_update_params }
          expect(response).to render_template :edit
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    let!(:other_user_post) { create(:post) }

    context "ログイン済の場合" do
      before do
        user.confirm
        sign_in user
      end

      context "自分のコメントを削除する場合" do
        it 'リクエストが成功すること' do
          delete post_path post
          expect(response).to have_http_status(302)
        end
        it 'コメントのデータが削除されること' do
          expect do
            delete post_path post
          end.to change(Post, :count).by(-1)
        end
        it 'お店の詳細画面にリダイレクトすること' do
          delete post_path post
          expect(response).to redirect_to restaurant_path post.restaurant
        end
      end

      context "他人のコメントを削除する場合" do
        it 'コメントのデータが削除されないこと' do
          expect do
            delete post_path other_user_post
          end.to change(Post, :count).by(-1)
        end
        it 'お店の詳細画面に戻ること' do
          delete post_path other_user_post
          expect(response).to redirect_to restaurant_path other_user_post.restaurant
        end
      end
    end

    context "未ログインの場合" do
      it "ログイン画面へ画面遷移するとこ" do
        delete post_path post
        expect(response).to redirect_to new_user_session_path
      end
      it "コメントのデータが削除されないこと" do
        expect do
          delete post_path post
        end.to change(Post, :count).by(0)
      end
    end
  end
end
