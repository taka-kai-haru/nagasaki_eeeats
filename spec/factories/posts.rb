FactoryBot.define do
  factory :post do
    association :restaurant
    association :user
    atmosphere {3}
    accessibility {3}
    cost_performance {3}
    assortment {3}
    service {3}
    delicious {3}
    likes {false}
    dislikes {false}
    comment {"test"}
  end
end
