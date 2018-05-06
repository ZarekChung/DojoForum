class PostsController < ApplicationController
  def index
    @categories = Category.all
    @posts = Post.all.order(:id).page(params[:page]).per(20)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @replies = @post.replies.page(params[:page]).per(20)
    @reply = Reply.new
  end

  def new
    @post = Post.new
    @privacy = Privacy.all
  end

  def create
    @privacy = Privacy.all
    @post = Post.new(post_params)
    categories = params[:post][:categories]
    @post.user = User.all.sample

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

  def edit
    @post = Post.find(params[:id])
    @privacy = Privacy.all
  end

  def update
    @post = Post.find(params[:id])
    categories = params[:post][:categories]
    categories.each do |category|
      #新增
      if !category.blank?
        @post.category_of_posts.each do |categoryofpost|
          categoryofpost.update_category(@post,category,categoryofpost.id)
        end
      else
        #blank  
      end
      #刪除
      #@post.category_of_posts.where(category: category).destroy if category.blank?
    end

    if @post.update_attributes(post_params)
      flash[:notice] = "post was scuccessfully updated"
      redirect_to post_path(@post)
    else
      flash.now[:alert] ="post was failed to update"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    #if current_user.admin?
      @post.destroy
      redirect_to posts_path
    #end
  end

  private
  def post_params
    params.require(:post).permit(:title,:article,:privacy_id,:photo)
  end

end
