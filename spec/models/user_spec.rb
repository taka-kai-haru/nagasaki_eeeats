require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # it "名前、メールアドレス、パスワードが有効であること" do
  #   user = FactoryBot.build(:user)
  #   expect(user).to be_valid
  # end
  #
  # it"名前が無い場合無効であること" do
  #   user = FactoryBot.build(:user, name: nil)
  #   user.valid?
  #   expect(user.errors[:name]).to include("が入力されていません。")
  # end
  #
  # it"重複した名前の場合無効であること" do
  #   user1 = FactoryBot.create(:user)
  #   user2 = FactoryBot.build(:user, name: user1.name)
  #   user2.valid?
  #   expect(user2.errors[:name]).to include("は既に使用されています。")
  # end
  #
  # it"名前が16文字以上の場合無効であること" do
  #   user = FactoryBot.build(:user, name: "1" * 16 )
  #   user.valid?
  #   expect(user.errors[:name]).to include("は15文字以下に設定して下さい。")
  # end
  #
  # it"名前が15文字以上の場合有効であること" do
  #   user = FactoryBot.build(:user, name: "1" * 15)
  #   expect(user).to be_valid
  # end
  #
  # it"メールアドレスが無い場合無効であること" do
  #   user = FactoryBot.build(:user, email:nil)
  #   user.valid?
  #   expect(user.errors[:email]).to include("が入力されていません。")
  # end
  #
  # it"パスワードが無い場合無効であること" do
  #   user = FactoryBot.build(:user, password:nil)
  #   user.valid?
  #   expect(user.errors[:password]).to include("が入力されていません。")
  # end
  #
  # it"重複したメールアドレスの場合無効であること" do
  #   user1 = FactoryBot.create(:user)
  #   user2 = FactoryBot.build(:user, email: user1.email)
  #   user2.valid?
  #   expect(user2.errors[:email]).to include("は既に使用されています。")
  # end
  #
  # it"パスワードが5文字以下の場合無効であること" do
  #   user = FactoryBot.build(:user, password: "1" * 5)
  #   user.valid?
  #   expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
  # end
  #
  # it"パスワードとパスワード確認用が一致しない場合無効であること" do
  #   user = FactoryBot.build(:user, password_confirmation:"123457")
  #   user.valid?
  #   expect(user.errors[:password_confirmation]).to include("がパスワードと合っていません。")
  # end

end
