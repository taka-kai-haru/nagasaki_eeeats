class Restaurant < ApplicationRecord
  belongs_to :area
  belongs_to :restaurant_type
  has_many :posts, dependent: :destroy
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :name, presence: true, uniqueness: true
  validates :tel,  presence: true, format: { with: VALID_PHONE_REGEX, allow_blank: true}, uniqueness: true
  # validates :address, presence: true, inclusion: {in: %w(長崎県*)}
  validates :address, presence: true, format: {with: /長崎県./}
  validates :restaurant_type_id, presence: true
  validates :area_id, presence: true
  validates :latitude, presence: true, numericality: {greater_than: 0}
  validates :longitude, presence: true, numericality: {greater_than: 0}

  # GoogleMapデフォルト位置(長崎市中心)
  GMAP_DEF_LAT = 32.752443
  GMAP_DEF_LNG = 129.870812

  #検索用searchメソッド
  scope :search, -> (search_params) do  
    return if search_params.blank?

    area_id_is(search_params[:area_id])
      .restaurant_type_id_is(search_params[:restaurant_type_id])
      .name_like(search_params[:name])
        .likes(search_params[:likes])
        .dislikes(search_params[:dislikes])
        .present_position(search_params[@lat_lag])
  end



  #検索用scope
  scope :area_id_is, -> (area_id) { where(area_id: area_id) if area_id.present? } 
  scope :restaurant_type_id_is, -> (restaurant_type_id) { where(restaurant_type_id: restaurant_type_id) if restaurant_type_id.present? }
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :likes, -> (likes) { where(posts: {likes: true}) if likes == true }
  scope :dislikes, -> (dislikes) { where(posts: {dislikes: true}) if dislikes == true }
  scope :present_position, ->(lat_lag) { within(5, origin: [lat_lag]) if lat_lag.present?}
end
