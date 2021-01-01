require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  describe "get#index" do
    context "ユーザが存在する場合" do
      let(:user) { create(:user) }
      it "ログイン後、正常にレスポンスを返すこと" do
        user.confirm
        sign_in user
        get restaurants_path
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end
  end


end
