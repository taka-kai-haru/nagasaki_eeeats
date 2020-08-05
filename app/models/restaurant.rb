class Restaurant < ApplicationRecord
  belongs_to :area
  belongs_to :restaurant_type
  has_many :posts

  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :name, presence: true, uniqueness: true
  validates :tel,  presence: true, format: { with: VALID_PHONE_REGEX, allow_blank: true}, uniqueness: true
  validates :address, presence: true
  validates :restaurant_type_id, presence: true
  validates :area_id, presence: true
end
