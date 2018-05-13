class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :get_category

  def index
    if params[:id]
      @category = Category.find(params[:id])
    else
      @category = Category.new
    end
  end

  def create
  @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "category was successfully created"
      redirect_to admin_categories_path
    else
      render :index
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path
      flash[:notice] = "category was successfully updated"
    else
      render :index
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if@category.destroy
      flash[:alert] = "category was successfully deleted"
      redirect_to admin_categories_path
    else
      render :index
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def get_category
    @categories = Category.all
  end
end
