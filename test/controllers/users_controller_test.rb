require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # include Devise::ControllerHelpers
  include Devise::Test::IntegrationHelpers
  # def setup
  #   @user = users( :michael )
  #   sign_in(@user)
  # end

  # include Devise::TestHelpers

  # setup do
  #   get '/users/sign_in'
  #   sign_in users(:michael)
  #   post user_session_url
  # end
  def setup
    @user = users(:michael)
    
  end

  def user_add
    user = User.new name:'john', release: false, email: 'john@example.com', password: '12345678'
    user.skip_confirmation!
    user.save!
  end

  #ユーザー登録画面アクセスできるかを検証
  test "should get new" do
    get new_user_registration_url
    assert_response :success
  end

  #ログイン画面にアクセスできるかを検証
  test "should get login" do
    get new_user_session_url
    assert_response :success
  end

  test "should login after get restaurants_index" do
    get new_user_session_url
    sign_in(@user)
    post user_session_url
    get restaurants_path
    assert_response :success
  end

  test "should signin after get restaurants_index" do
    get new_user_registration_url
    user_add
    get new_user_session_url
    sign_in(@user)
    post user_session_url
    get restaurants_path
    assert_response :success
  end

end