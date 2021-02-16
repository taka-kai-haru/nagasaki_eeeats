class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :params_check, only:[:new]

  include PostsHelper

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @post.restaurant_id = params[:restaurant_id]
    default_score_set
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      @post.point_update @post.restaurant_id
      flash[:info] = "コメントの登録しました。"
      redirect_to restaurant_path @post.restaurant
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id && @post.restaurant_id == post_params[:restaurant_id].to_i
      if @post.update(post_params)
        @post.point_update @post.restaurant_id
        flash[:info] = "コメントの更新をしました。"
        # redirect_to "/restaurants/#{@post.restaurant_id}"
        redirect_to restaurant_path @post.restaurant
      else
        flash[:warning] = "コメントを更新することができませんでした。"
        redirect_to restaurant_path @post.restaurant
      end
    else
      flash[:warning] = "別のユーザーのコメントを更新することはできません。"
      redirect_to restaurant_path @post.restaurant
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id = current_user.id
      @post.destroy
      flash[:info] = "コメントの削除をしました。"
      # redirect_to "/restaurants/#{@post.restaurant_id}"
      redirect_to restaurant_path @post.restaurant
    else
      flash[:warning] = "別のユーザーのコメントを削除することができません。"
      # render "/restaurants/#{@post.restaurant_id}"
      render restaurant_path @post.restaurant
    end
  end

  def img_destroy
    @post = Post.find(params[:id])
    if @post.images.purge
      redirect_to edit_post_path(@post)
    else
      render :edit
    end
  end

  private

  def params_check
    if params[:restaurant_id].nil?
      flash[:notice] = "お店の情報が取得できませんでした。"
      redirect_to restaurants_path
    end
  end

  def post_params
    params.require(:post).permit(:restaurant_id, :delicious, :atmosphere, :accessibility, :cost_performance, :assortment, :service, :comment, :likes, :dislikes, images: [])
  end

end
