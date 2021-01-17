class Post < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  has_many_attached :images
  has_rich_text :comment
  default_scope -> { order(updated_at: :desc) }
  validates :delicious,         numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :atmosphere,        numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :accessibility,     numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :cost_performance,  numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :assortment,        numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :service,           numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :images,            content_type: { in: %w[image/jpeg image/gif image/png],
                                                message: "jpeg,gif,pngの拡張子にしてください。" },
                                                size:         { less_than: 5.megabytes,
                                                message: "5MBより小さくしてください。" }
  validate :validate_comment_attachment_byte_size
  validate :validate_comment_attachments_count
  validates :restaurant_id , uniqueness: { scope: :user_id }

  IMAGE_MAX_SAVE = 3
  ONE_KILOBYTE = 1024
  MEGA_BYTES = 3
  MAX_COMMENT_ATTACHMENT_BYTE_SIZE = MEGA_BYTES * 1000 * ONE_KILOBYTE
  MAX_COMMENT_ATTACHMENTS_COUNT = 4


  # Restaurant Point更新
  def point_update(restaurant_id)
    point = 0
    post_count = 0

    Post.where(restaurant_id: restaurant_id).find_each do |post|
      point += ((post.atmosphere.to_f + post.accessibility.to_f + post.cost_performance.to_f + post.assortment.to_f + post.service.to_f + post.delicious.to_f) / 6).round(1).to_f
      post_count += 1
    end
    restaurant = Restaurant.find_by(id: restaurant_id)
    if post_count == 0
      restaurant.point = 0
    else
      restaurant.point = (point / post_count).round(1)
    end
    restaurant.save
  end

  private

  def validate_comment_attachment_byte_size
    comment.body.attachables.grep(ActiveStorage::Blob).each do |attachabl|
      if attachabl.byte_size > MAX_COMMENT_ATTACHMENT_BYTE_SIZE
        errors.add(
            :base,
            :comment_attachement_byte_size_is_too_big,
            max_comment_attachement_mega_byte_size: MEGA_BYTES,
            bytes: attachabl.byte_size,
            max_bytes: MAX_COMMENT_ATTACHMENT_BYTE_SIZE
        )
      end
    end
  end

  def validate_comment_attachments_count
    if comment.body.attachables.grep(ActiveStorage::Blob).count > MAX_COMMENT_ATTACHMENTS_COUNT
      errors.add(
          :content,
          :attachments_count_is_too_big,
          max_comment_attachments_count: MAX_COMMENT_ATTACHMENTS_COUNT
      )
    end
  end

  def image_small
    self.images.sample.variant(resize: '200x200').processed
  end

end
