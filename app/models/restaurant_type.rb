class RestaurantType < ApplicationRecord
  has_many :restaurants
  # has_many :areas, through: :restaurants

end
