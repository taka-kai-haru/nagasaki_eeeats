FactoryBot.define do
  factory :area do
    areas_name {"長崎市"}
    association :prefecture
  end
end
