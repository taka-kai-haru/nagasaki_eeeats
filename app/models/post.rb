class Post < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  has_many_attached :images
  default_scope -> { order(updated_at: :desc) }
  validates :delicious,         numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 5}
  validates :atmosphere,        numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 5}
  validates :accessibility,     numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 5}
  validates :cost_performance,  numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 5}
  validates :assortment,        numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 5}
  validates :service,           numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 5}
  validates :images,            content_type: { in: %w[image/jpeg image/gif image/png],
                                                message: "jpeg,gif,pngの拡張子にしてください。" },
                                                size:         { less_than: 5.megabytes,
                                                message: "5MBより小さくしてください。" }
  IMAGE_MAX_SAVE = 3
end
