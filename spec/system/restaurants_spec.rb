require 'rails_helper'

RSpec.describe "Restaurants", type: :system do

  scenario "お店の情報登録" do
    user = create(:user)
    user.confirm
    sign_in user

    visit restaurants_path

    expect {
      click_link '+お店の登録'
      fill_in 'restaurant[name]', with: 'TestShop'
      select '居酒屋', from: 'restaurant[restaurant_type_id]'
      select '長崎市', from: 'restaurant[area_id]'
      fill_in 'restaurant[tel]', with: '09011111111'
      fill_in 'restaurant[url]', with: 'http:www/example.com'
      fill_in 'restaurant[address]', with: '長崎県長崎市'
      find('#latitude', visible: false).set('32.752443')
      find('#longitude', visible: false).set('129.870812')
      click_button 'お店の情報登録'

      aggregate_failures do
        expect(page).to have_content "お店の情報の登録をしました。"
        expect(page).to have_selector '.page_title', text: 'コメントの登録'
      end
    }.to change(Restaurant, :count).by(1)
  end

  scenario "お店の情報更新" do
    user = create(:user)
    restaurant = create(:restaurant)
    user.confirm
    sign_in user

    visit restaurants_path

    find("#restaurant_" + restaurant.id.to_s).click
    click_link 'お店の変更'
    fill_in 'restaurant[address]', with: '長崎県佐世保市'
    click_button 'お店情報の更新'
    aggregate_failures do
      expect(page).to have_content "お店の情報の更新をしました。"
      expect(page).to have_selector '.page_title', text: 'お店の情報'
      expect(page).to have_selector '#address', text: '長崎県佐世保市'
    end
  end

  scenario "お店の情報削除" do
    user = create(:user)
    restaurant = create(:restaurant)
    user.confirm
    sign_in user

    visit restaurants_path

    find("#restaurant_" + restaurant.id.to_s).click
    expect {
      click_link 'お店の削除'
      # page.accept_confirm
      expect(page).to have_content "お店の情報の削除をしました。"
      expect(page).to have_selector '.page_title', text: 'お店一覧'
    }.to change(Restaurant, :count).by(-1)
  end

  context "お店のデータが10件の場合" do
    scenario "お店一蘭ページネーション表示なし" do

      user = create(:user)
      (1..10).each do |i|
        eval("restaurant#{i} = create(:restaurant)")
      end

      user.confirm
      sign_in user

      visit restaurants_path
      expect(page).to_not have_selector '.page-link', text: '1'
    end
  end

  context "お店のデータ11件の場合" do
    scenario "お店一蘭ページネーション表示あり" do
      user = create(:user)
      (1..11).each do |i|
        eval("restaurant#{i} = create(:restaurant)")
      end

      user.confirm
      sign_in user

      visit restaurants_path
      expect(page).to have_selector '.page-link', text: '1'
      expect(page).to have_selector '.page-link', text: '2'
    end
  end

  context "非公開ユーザーがコメント登録している場合" do
    scenario "お店の一蘭で評価の表示がされないこと" do
      private_user = create(:user, release: false)
      private_post = create(:post, user: private_user)
      user = create(:user)

      user.confirm
      sign_in user

      visit restaurants_path
      expect(page).to have_content "全体評価：なし"
    end
  end

  context "公開ユーザーがコメント登録している場合" do
    scenario "お店の一蘭で評価の表示がされること" do
      open_user = create(:user, release: true)
      open_post = create(:post, user: open_user)
      user = create(:user)

      user.confirm
      sign_in user

      visit restaurants_path
      expect(page).to_not have_content "全体評価：なし"
    end
  end



  
  
  
end