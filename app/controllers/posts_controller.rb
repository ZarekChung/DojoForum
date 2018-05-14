class PostsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :set_post, :except=>[:index,:create,:new,:feeds]
  def index
    @categories = Category.all
    @posts = Post.filter_by_reviewed_status(current_user).where(is_draft:false).order(:id).page(params[:page]).per(20)
  end

  def show
    @replies = @post.replies.page(params[:page]).per(20)
    @post.view_count+=1
    @post.save
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
    @post.user = current_user
    if @post.save
      @post.update_attributes(is_draft: false) if set_publishing?
    #flash 會留到下一個request
    Category.all.each do |category|
      if categories.to_a.include?(category.id.to_s)
      @post.category_of_posts.create!(post: @post, category_id: category.id,is_checked:true)
      else
      @post.category_of_posts.create!(post: @post, category_id: category.id,is_checked:false)
      end
    end

    flash[:notice] = "post was scuccessfully created"
      if set_publishing?
        redirect_to posts_path
      else
        redirect_to "/users/#{current_user.id}?draft"
      end
    else
    #flash.now 只存在現在這個request
    flash.now[:alert] = "post was failed to create"
    render :new
    end

  end

  def edit
    if current_user == @post.user
      @privacy = Privacy.all
    else
      flash[:notice] ="post user wrong"
      redirect_to post_path(@post)
    end
  end

  def update
    categories = params[:post][:categories]
    @post.category_of_posts.each do |categoryofpost|
      if categories.to_a.include?(categoryofpost.category_id.to_s)
      categoryofpost.update_attributes(is_checked: true )
      else
      categoryofpost.update_attributes(is_checked: false )
      end
    end
    if @post.update_attributes(post_params)
      @post.update_attributes(is_draft: false) if set_publishing?
      flash[:notice] = "post was scuccessfully updated"
      if set_publishing?
        redirect_to post_path(@post)
      else
        redirect_to "/users/#{current_user.id}?draft"
      end
    else
      flash.now[:alert] ="post was failed to update"
      render :edit
    end
  end

  def destroy
    if current_user == @post.user
      @post.destroy
      redirect_to posts_path
    else
      flash[:notice] ="post user wrong"
      redirect_to post_path(@post)
    end
  end

  def collect
   @post.collects.create!(user: current_user)
   redirect_back(fallback_location: post_path(@post))
  end

  def uncollect
   collects = Collect.where(post: @post, user: current_user)
   collects.destroy_all
   redirect_back(fallback_location: post_path(@post))
  end

  def feeds
    @postsTo10 = Post.order(replies_count: :desc).limit(10)
    @usersTo10 = User.order(replies_count: :desc).limit(10)
  end

  private
  def set_publishing?
    params[:commit] == "Update Post" || params[:commit] == "Create Post"
  end

  def set_post
    begin
      @post = Post.filter_by_reviewed_status(current_user).find(params[:id])
    rescue
      flash[:notice] ="post not found"
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post).permit(:title,:article,:privacy_id,:photo)
  end

end
