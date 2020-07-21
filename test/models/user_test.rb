require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(
      name: "Example User", 
      email: "user@example.com", 
      release: false,
      # encrypted_password: Devise::Encryptor.digest(User, 'password')
      # encrypted_password: User.new.send(:password_digest, '123456')
      # encrypted_password: '123456'
      password: '123123',
      password_confirmation: '123123'
      )
  end

  #userテーブルが更新できることを検証
  test "should be valid" do
    assert @user.valid?
  end

  #nameが空白の場合エラー
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  #nemailが空白の場合エラー
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  #passwordが空白の場合エラー
  test "password should be present" do
    @user.password = ""
    assert_not @user.valid?
  end

  #password確認が空白の場合エラー
  test "password_confirmation should be present" do
    @user.password_confirmation = ""
    assert_not @user.valid?
  end

  #nameの文字列がNAME_MAXMUM以上の場合エラー
  test "name should not be too long" do
    @user.name = "a" * (User::NAME_MAXMUM + 1)
    assert_not @user.valid?
  end

  #passwordの文字列が長い場合エラー
  test "password should not be too long" do
    @user.password = "a" * 129
    @user.password_confirmation = "a" * 129
    assert_not @user.valid?
  end

  #passwordの文字列が短い場合エラー
  test "password should not be too short" do
    @user.password = "a" * 5
    @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  #passwordとpassword確認が合っていない場合エラー
  test "password password_confirmation should not be unmatch" do
    @user.password = "a" * 6
    @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end

end
