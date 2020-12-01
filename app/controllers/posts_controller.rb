class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :params_check, only:[:new]

  include PostsHelper

  def show
    # binding.pry
    @post = Post.find(params[:post_id])
    # @my_post = Post.find_by(id: params[:post_id], user_id: current_user.id)
    # @post = Post.find_by(id: params[:post_id]).where.not(user_id: current_user.id)
  end

  def new
    @post = Post.new
    @post.restaurant_id    = params[:restaurant_id]
    default_score_set
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # @post.images.attach(params[:post][:images])
    # binding.pry
    if @post.save
      @post.point_update @post.restaurant_id
      flash[:info] = "コメントの登録しました。"
      redirect_to "/restaurants/#{@post.restaurant_id}"
    else
      render :new
    end
  end
  

  def edit
    @post = Post.find(params[:post_id])
  end

  def update
    # binding.pry
    @post = Post.find(params[:id])
    # binding.pry
    # restaurant_id = @post.restaurant_id
    # @post.images.detach #image紐づけ解除
    if @post.update(post_params)
      @post.point_update @post.restaurant_id
      flash[:info] = "コメントの更新をしました。"
      redirect_to "/restaurants/#{@post.restaurant_id}"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    # restaurant_id = @post.restaurant_id
    @post.destroy
    flash[:info] = "コメントの削除をしました。"
    redirect_to "/restaurants/#{@post.restaurant_id}"
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
