class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @categoryofposts = CategoryOfPost.where(category_id: params[:id])
  end
end
