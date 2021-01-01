require 'rails_helper'

RSpec.describe User, type: :model do

  describe "バリデーションのテスト" do
    describe "全ての項目" do
      context "入力時" do
        it "名前、メールアドレス、パスワードが有効であること" do
          user = build(:user)
          expect(user).to be_valid
        end
      end
    end

    describe "name" do
      context "ない場合" do
        it"無効であること" do
          user = build(:user, name: nil)
          user.valid?
          expect(user.errors[:name]).to include("が入力されていません。")
        end
      end

      context "重複した場合" do
        it"無効であること" do
          user1 = create(:user)
          user2 = build(:user, name: user1.name)
          user2.valid?
          expect(user2.errors[:name]).to include("は既に使用されています。")
        end
      end

      context "16文字以上の場合" do
        it"無効であること" do
          user = build(:user, name: "1" * 16 )
          user.valid?
          expect(user.errors[:name]).to include("は15文字以下に設定して下さい。")
        end
      end

      context "15文字以下の場合" do
        it"有効であること" do
          user = build(:user, name: "1" * 15)
          expect(user).to be_valid
        end
      end
    end

    describe "email" do
      context "ない場合" do
        it"無効であること" do
          user = build(:user, email:nil)
          user.valid?
          expect(user.errors[:email]).to include("が入力されていません。")
        end
      end

      context "重複した場合" do
        it"無効であること" do
          user1 = create(:user)
          user2 = build(:user, email: user1.email)
          user2.valid?
          expect(user2.errors[:email]).to include("は既に使用されています。")
        end
      end
    end

    describe "password" do
      context "ない場合" do
        it"無効であること" do
          user = build(:user, password:nil)
          user.valid?
          expect(user.errors[:password]).to include("が入力されていません。")
        end
      end

      context "5文字以下の場合" do
        it"無効であること" do
          user = build(:user, password: "1" * 5)
          user.valid?
          expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
        end
      end

      context "パスワードとパスワード確認用が一致しない場合" do
        it"無効であること" do
          user = build(:user, password_confirmation:"123457")
          user.valid?
          expect(user.errors[:password_confirmation]).to include("がパスワードと合っていません。")
        end
      end
    end
  end


















end
