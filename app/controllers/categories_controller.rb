class CategoriesController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  def show
    @categories = Category.all
    catregory = Category.find_by(id: params[:id])
    categoryofposts = catregory.category_of_posts.where(is_checked:true)
    @posts = Post.where(:id => categoryofposts.select(:post_id)).filter_by_reviewed_status(current_user).where(is_draft:false).page(params[:page]).per(20)
    #@posts = Post.where(:id => categoryofposts.select(:post_id)).where(is_draft:false).page(params[:page]).per(20)
  end
end
