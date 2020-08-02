class Prefecture < ApplicationRecord
  has_many :areas
  # has_many :restaurants, through: :areas
end
