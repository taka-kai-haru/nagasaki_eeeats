class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  
  def index

    @search_params = restaurant_search_params
    # binding.pry
    #homeからのパラメーターセット
    @search_params[:area_id] = params[:area_id] if !params[:area_id].nil?
    # binding.pry
    # @restaurants = Restaurant.search(@search_params).includes(:restaurant_type)
    @restaurants = Restaurant.includes(:posts).search(@search_params).order(point: :desc).page(params[:page]).per(6)

  end

  def show
    @restaurant = Restaurant.find(params[:id])
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
    if @restaurant.update(restaurant_params)
      flash[:info] = "お店の情報の更新をしました。"
      redirect_to restaurant_path
    else
      render :edit
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :restaurant_type_id, :area_id, :tel, :url, :address, :closed, :latitude, :longitude)
  end

  def restaurant_search_params
    @lat_lag = [params[:present_position_lat],params[:present_position_lng]]
    params.fetch(:search, {}).permit(:area_id, :restaurant_type_id, :name, :likes, :dislikes, :my_post_select, @lat_lag)
  end

end
