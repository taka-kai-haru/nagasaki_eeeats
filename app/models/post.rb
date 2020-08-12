class Post < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :delicious,        numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 5}
  validates :atmosphere,       numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 5}
  validates :accessibility,    numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 5}
  validates :cost_performance, numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 5}
  validates :assortment,       numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 5}
  validates :service,          numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 5}

end
