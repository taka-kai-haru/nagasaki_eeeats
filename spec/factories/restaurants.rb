FactoryBot.define do
  factory :restaurant do
    association :area
    association :restaurant_type
    sequence(:name) {|n| "TestShop#{n}"}
    sequence(:tel) {|n| "080#{format("%08d", n)}"}
    url {"https://www.example.com"}
    address {"長崎県長崎市"}
    closed {false}
    latitude {32.752443}
    longitude {129.870812}
    point {3}
    updatetime {Date.today.to_time}
  end
end
