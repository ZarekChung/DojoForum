class PostsController < ApplicationController

  def index
    @posts = Post.all
    @categories = Category.all
    #@categories = Category.all
    #@privacy = Privacy.all
  end

  def new
    @post = Post.new
    @privacy = Privacy.all
  end

  def create
    @privacy = Privacy.all
    @post = Post.new(post_params)
    categories = params[:post][:categories]

    if @post.save
    #flash 會留到下一個request
    categories.each do |category|
      if !category.blank?
      @post.category_of_posts.create!(post: @post, category_id: category)
      end
    end
    flash[:notice] = "post was scuccessfully created"
    redirect_to posts_path
    else
    #flash.now 只存在現在這個request
    flash.now[:alert] = "post was failed to create"
    render :new
    end

  end

  private
  def post_params
    params.require(:post).permit(:title,:article,:privacy_id,:photo)
  end

end
