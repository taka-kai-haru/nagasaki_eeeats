class PostsController < ApplicationController
  def new
    @post = Post.new
    @post.restaurant_id = params[:restaurant_id]
  end

  def create

  end
  

  def edit
  end
end
