class StaticPagesController < ApplicationController
  def home
    @areas = Area.all
  end

  def about
  end
end
