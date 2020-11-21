class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  
  def index

    @search_params = restaurant_search_params
    # binding.pry
    #homeからのパラメーターセット
    @search_params[:area_id] = params[:area_id] if !params[:area_id].nil?
    # binding.pry
    # @restaurants = Restaurant.search(@search_params).includes(:restaurant_type)
    # @restaurants = Restaurant.includes(:posts).search(@search_params).order(point: :desc).page(params[:page]).per(4)

    @restaurants = Restaurant.includes(:posts).search(@search_params).order(point: :desc).page(params[:page]).per(4)

    # @restaurants = Restaurant.search(@search_params)

    # @restaurants.order_location_by(search(@search_params[:present_position_lat]), search(@search_params[:present_position_lng])) unless search(@search_params[:present_position_lat]).present? && search(@search_params[:present_position_lng]).present?
    # @restaurants.order_location_by(@search_params[:present_position_lat], @search_params[:present_position_lng]) if @search_params[:present_position_lat].present? && @search_params[:present_position_lng].present?
    # @restaurants.order_location_by(search[:present_position_lat], search[:present_position_lng]) if search[:present_position_lat].present? && search[:present_position_lng].present?
    # @restaurants.order_location_by(32.7286784,129.892352)
  end

  def show
    # indwx情報保存
    session[:return_to] ||= request.referer
    @restaurant = Restaurant.find(params[:id])
    flash.now[:notice] = "閉店している可能性があります。" if @restaurant.closed
    # @restaurant_type = RestaurantType.find(@restaurant.restaurant_type_id)
    # @area = Area.find(@restaurant.area_id)
  end

  def new
    @restaurant = Restaurant.new
    # @areas = Area.all
    # @restauranttypes = RestaurantType.all
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.updatetime = Date.today.to_time
    # binding.pry
    if @restaurant.save
      flash[:info] = "お店の情報の登録をしました。"
      redirect_to new_post_path(restaurant_id: @restaurant.id)
    else
      # binding.pry
      render :new
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.updatetime = Date.today.to_time
    if @restaurant.update(restaurant_params)
      flash[:info] = "お店の情報の更新をしました。"
      redirect_to restaurant_path
    else
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:post_id])
    # restaurant_id = @post.restaurant_id
    @restaurant.destroy
    flash[:info] = "お店の情報の削除をしました。"
    # 遷移元リンクセッション削除
    session.delete(:return_to)
    # 一覧へ移動
    redirect_to restaurants_path
  end

  def return
    if session[:return_to].nil?
      redirect_to restaurants_path
    else
      redirect_to session.delete(:return_to)
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :restaurant_type_id, :area_id, :tel, :url, :address, :closed, :latitude, :longitude)
  end

  def restaurant_search_params
    # @lat_lag = [params[:search][:present_position_lat], params[:search][:present_position_lng]] if params[:search][:present_position_lat].present? && params[:search][:present_position_lng].present?
    params.fetch(:search, {}).permit(:area_id, :restaurant_type_id, :name, :likes, :dislikes, :my_post_select, @lat_lag)
  end

end
