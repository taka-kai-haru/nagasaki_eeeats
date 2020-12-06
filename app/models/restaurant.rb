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
    # lat_lag = Array.new
    # lat_lag = [search_params[:present_position_lat], search_params[:present_position_lng]] if search_params[:present_position_lat].present? && search_params[:present_position_lng].present?
    area_id_is(search_params[:area_id])
      .restaurant_type_id_is(search_params[:restaurant_type_id])
      .name_like(search_params[:name])
        .likes(search_params[:likes])
        .dislikes(search_params[:dislikes])
        .order_evaluation(search_params[:order])
        .order_my_evaluation(search_params[:order])
        .order_near(search_params[:order],search_params[:present_position_lat],search_params[:present_position_lng])
        .my_post_select_is(search_params[:my_post_select],search_params[:user_id])
        # .present_position([lat: search_params[:present_position_lat], lag: search_params[:present_position_lng]])
  end



  #検索用scope
  scope :area_id_is, -> (area_id) { where(area_id: area_id) if area_id.present? } 
  scope :restaurant_type_id_is, -> (restaurant_type_id) { where(restaurant_type_id: restaurant_type_id) if restaurant_type_id.present? }
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :likes, -> (likes) { where(posts: {likes: true}) if likes == '1'}
  scope :dislikes, -> (dislikes) { where(posts: {dislikes: true}) if dislikes == '1'}
  scope :order_evaluation, -> (order) { order('point desc NULLS LAST') if order == '0'}
  scope :order_my_evaluation, -> (order) { order('(posts.atmosphere + posts.accessibility + posts.cost_performance + posts.assortment + posts.service + posts.delicious) desc NULLS LAST') if order == '1'}
  scope :order_near, -> (order,latitude,longitude) { by_distance(:origin => [latitude.to_f, longitude.to_f]) if order == '2' }
  scope :my_post_select_is, -> (my_post_select,user_id) { where(posts: {user_id: user_id}) if my_post_select == '1'}



end
