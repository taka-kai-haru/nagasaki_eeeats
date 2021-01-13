require 'rails_helper'

RSpec.describe "Posts", type: :system do

  scenario "コメントの登録" do
    user = create(:user)
    restaurant = create(:restaurant)
    user.confirm
    sign_in user

    visit restaurant_path restaurant

    expect {
      click_link '+コメントの新規登録'
      find('#submit').click

      aggregate_failures do
        expect(page).to have_content "コメントの登録しました。"
        expect(page).to have_selector '.page_title', text: 'お店の情報'
      end
    }.to change(Post, :count).by(1)
  end

  # scenario "コメントの更新"  do
  #   user = create(:user)
  #   post = create(:post, user: user)
  #   user.confirm
  #   sign_in user
  #
  #   visit restaurant_path post.restaurant
  #   click_link "コメントの編集"
  #   # find("#post_comment").set("更新したコメント内容です。")
  #   # fill_in_rich_text_area 'post_comment', with: '更新したコメント内容です。'
  #   # find(:css, "#post_comment").click.set('更新したコメント内容です。')
  #   # find("#post_comment").click.set('更新したコメント内容です。')
  #   # find('#post_comment_trix_input_post', visible: false).set('更新したコメント内容です。')
  #   # find('#post_comment').set('更新したコメント内容です。')
  #   find('trix-editor').set('更新したコメント内容です。')
  #   # fill_in 'post[comment]', with: '更新したコメント内容です。'
  #   # attach_file "micropost_picture",  "#{Rails.root}/spec/factories/rails.png"
  #   # click_button "Post"
  #   # fill_in 'post[comment]', with: '更新したコメント内容です。'
  #   find('#submit').click
  #   aggregate_failures do
  #     expect(page).to have_content "コメントの更新をしました。"
  #     expect(page).to have_selector '.page_title', text: 'お店の情報'
  #     # expect(page).to have_content "更新したコメント内容です。"
  #     expect(page).to have_selector 'p', text: '更新したコメント内容です。'
  #   end
  # end

  scenario "コメントの削除"  do
    user = create(:user)
    post = create(:post, user: user)
    user.confirm
    sign_in user

    visit restaurant_path post.restaurant
    expect {
      click_link "コメントの削除"
      expect(page).to have_content "コメントの削除をしました。"
      expect(page).to have_selector '.page_title', text: 'お店の情報'
    }.to change(Post, :count).by(-1)
  end

end