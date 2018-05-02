class PostsController < ApplicationController

  def index

  end

  def new
    @post = Post.new
    @categories = Category.all
    @privacy = Privacy.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
    #flash 會留到下一個request
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
    params.require(:post).permit(:title,:article,:photo,:privacy_id,:categories)

  end

end
