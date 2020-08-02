class Area < ApplicationRecord
  belongs_to :prefecture
  has_many :restaurants
  # has_many :restaurant_types, through: :restaurants
end
