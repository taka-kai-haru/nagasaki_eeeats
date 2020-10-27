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


  # Restaurant Point更新
  def point_update(restaurant_id)
    point = 0
    post_count = 0
    # posts = Post.find_by(restaurant_id: restaurant_id)
    # posts.each do |post|
    Post.where(restaurant_id: restaurant_id).find_each do |post|
      point += ((post.atmosphere.to_f + post.accessibility.to_f + post.cost_performance.to_f + post.assortment.to_f + post.service.to_f + post.delicious.to_f) / 6).round(1).to_f
      post_count += 1
    end
    restaurant = Restaurant.find_by(id: restaurant_id)
    restaurant.point = (point / post_count).round(1)
    restaurant.save
  end

end
