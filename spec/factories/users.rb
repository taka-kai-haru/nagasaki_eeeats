FactoryBot.define do
  factory :user do
    sequence(:name) {|n| "TestUser#{n}"}
    sequence(:email) {|n| "testuser#{n}@example.com"}
    release {true}
    admin {false}
    password {"123456"}
    password_confirmation {"123456"}
  end
end
