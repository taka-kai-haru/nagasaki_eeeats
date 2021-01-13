require 'rails_helper'

RSpec.describe "Sign-ups", type: :system do
  include ActiveJob::TestHelper

  scenario "user successfully signs up" do
    visit root_path
    find('#signup').click

    perform_enqueued_jobs do
      expect {
        fill_in "user[name]", with: "user"
        fill_in "user[email]", with: "test@example.com"
        fill_in "user[password]", with: "test123"
        fill_in "user[password_confirmation]", with: "test123"
        find("#signup").click
      }.to change(User, :count).by(1)

      expect(page).to \
        have_content "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
      expect(current_path).to eq root_path
    end

    mail = ActionMailer::Base.deliveries.last

    aggregate_failures do
      expect(mail.to).to eq ["test@example.com"]
      expect(mail.from).to eq ["nagasaki-eeeats@eats.com"]
      expect(mail.subject).to eq "メールアドレス確認メール"
      expect(mail.body).to match "ようこそ test@example.com様"
    end
  end
end
