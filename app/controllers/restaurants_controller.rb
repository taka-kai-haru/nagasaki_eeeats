class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only:[:new,:edit,:create]
  
  def index
    binding.pry
    if params[:area_id].nil?
      @restaurants = Restaurant.includes(:restaurant_type)
    else
      @restaurants = Restaurant.includes(:restaurant_type).where(area_id: params[:area_id])
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @restaurant_type = RestaurantType.find(@restaurant.restaurant_type_id)
    @area = Area.find(@restaurant.area_id)
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
      flash[:info] = "お店の登録が完了しました"
      redirect_to restaurants_path
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
      flash[:info] = "お店の更新が完了しました"
      redirect_to restaurant_path
    else
      render :edit
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :restaurant_type_id, :area_id, :tel, :url, :address)
  end
end
