require 'rails_helper'

RSpec.describe "Sign in", type: :system do
  let(:user) { create(:user) }

  before do
    user.confirm
  end

  scenario "user signs in" do
    visit root_path
    find('#login').click
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    find('#login').click
    expect(page).to have_content 'ログインしました。'
  end
end
