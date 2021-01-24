class PayRelationship < ApplicationRecord
  belongs_to :restaurant
  belongs_to :payment_method
end
