class PaymentMethod < ApplicationRecord
  has_many :pay_relationships
  has_many :restaurants, through: :pay_relationships
end
