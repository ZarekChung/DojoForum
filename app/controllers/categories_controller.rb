class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @categoryofposts = CategoryOfPost.where(category_id: params[:id],is_checked: true).order(:post_id).page(params[:page]).per(20)
  end
end
