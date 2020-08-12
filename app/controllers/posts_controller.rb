class PostsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :create]
  before_action :params_check, only:[:new]

  include PostsHelper

  def show
    # binding.pry
    @post = Post.find(params[:post_id])
  end

  def new
    @post = Post.new
    @post.restaurant_id    = params[:restaurant_id]
    default_score_set
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # binding.pry
    if @post.save
      flash[:info] = "登録しました。"
      redirect_to "/restaurants/#{@post.restaurant_id}"
    else
      render :new
    end
  end
  

  def edit
    @post = Post.find(params[:post_id])
  end

  def update
    @post = Post.find(params[:id])
    restaurant_id = @post.restaurant_id
    if @post = Post.update(post_params)
      flash[:info] = "変更しました。"
      redirect_to "/restaurants/#{restaurant_id}"
    else
      render :edit
    end
  end

  def params_check
    if params[:restaurant_id].nil?
      flash[:notice] = "お店の情報が取得できませんでした。"
      redirect_to restaurants_path
    end
  end

  def post_params
    params.require(:post).permit(:restaurant_id, :delicious, :atmosphere, :accessibility, :cost_performance, :assortment, :service, :comment)
  end

end
