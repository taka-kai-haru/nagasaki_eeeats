class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  
  def index

    # 検索条件パラメーターセット
    @search_params = restaurant_search_params

    # 検索用パラーメーターデフォルト値セット
    @search_params[:my_post_select] = '0' if @search_params[:my_post_select].nil?
    @search_params[:order] = '0' if @search_params[:order].nil?
    @search_params[:user_id] = current_user.id

    @restaurants = Restaurant.includes(:posts).search(@search_params).page(params[:page]).per(10)

    ## 一覧ページurl保存用セッション削除
    session.delete(:return_to)
  end

  def show
    # 一覧ページurl保存
    session[:return_to] = request.referer if session[:return_to].blank?

    @restaurant = Restaurant.find(params[:id])
    # 閉店時フラッシュを出す
    flash.now[:notice] = "閉店している可能性があります。" if @restaurant.closed

  end

  def new
    # 一覧ページurl保存
    session[:return_to] = request.referer if session[:return_to].blank?

    @restaurant = Restaurant.new

  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    # 更新日セット
    @restaurant.updatetime = Date.today.to_time
    if @restaurant.save
      flash[:info] = "お店の情報の登録をしました。"
      redirect_to new_post_path(restaurant_id: @restaurant.id)
    else
      render :new
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    # 更新日セット
    @restaurant.updatetime = Date.today.to_time
    if @restaurant.update(restaurant_params)
      flash[:info] = "お店の情報の更新をしました。"
      redirect_to restaurant_path
    else
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    # 一般ユーザーはほかの人の投稿がある場合削除させない。
    if !current_user.admin && @restaurant.posts.where.not(user_id: current_user.id).exists?
      flash.now[:danger] = "他の人のコメントがある為、削除できません。管理者に問合せください。"
      render :show
    else
      @restaurant.destroy
      flash[:info] = "お店の情報の削除をしました。"
      # 遷移元リンクセッション削除
      session.delete(:return_to)
      # 一覧へ移動
    redirect_to restaurants_path
    end
  end

  # 一覧(index)へ戻る
  def return
    if session[:return_to].nil?
      redirect_to restaurants_path
    else
      redirect_to session.delete(:return_to)
    end
  end

  private

  # String Parameter
  def restaurant_params
    params.require(:restaurant).permit(:name, :restaurant_type_id, :area_id, :tel, :url, :address, :closed, :latitude, :longitude)
  end

  # 検索条件セット
  def restaurant_search_params
    params.fetch(:search, {}).permit(:area_id, :restaurant_type_id, :name, :likes, :dislikes, :my_post_select, :order, :present_position_lat, :present_position_lng, :user_id)
  end

end
