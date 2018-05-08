class CategoriesController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  def show
    @categories = Category.all
    @categoryofposts = CategoryOfPost.where(category_id: params[:id],is_checked: true).order(:post_id).page(params[:page]).per(20)
  end
end
