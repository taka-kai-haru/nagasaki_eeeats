require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "NAGASAKI_Eeeeets"
  end

  test 'should get home' do
    get root_path
    assert_response :success
    assert_select "title", "ホーム | #{@base_title}"
  end

  test 'should get about' do
    get about_path
    assert_response :success
    assert_select "title", "NAGASAKI Eeeeetsについて | #{@base_title}"
  end
end
