class Restaurant < ApplicationRecord
  belongs_to :area
  belongs_to :restaurant_type
  has_many :posts, dependent: :destroy

  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :name, presence: true, uniqueness: true
  validates :tel,  presence: true, format: { with: VALID_PHONE_REGEX, allow_blank: true}, uniqueness: true
  validates :address, presence: true, inclusion: {in: %w(長崎県)}
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
  end



  #検索用scope
  scope :area_id_is, -> (area_id) { where(area_id: area_id) if area_id.present? } 
  scope :restaurant_type_id_is, -> (restaurant_type_id) { where(restaurant_type_id: restaurant_type_id) if restaurant_type_id.present? }
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }


end
