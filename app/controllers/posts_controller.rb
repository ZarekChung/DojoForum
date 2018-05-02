class PostsController < ApplicationController

  def new
    @post = Post.new
    @categories = Category.all
    @privacy = Privacy.all
  end
end
