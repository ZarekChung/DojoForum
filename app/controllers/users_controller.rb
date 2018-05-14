class UsersController < ApplicationController
  before_action :set_user

  def edit
    unless @user == current_user
     flash[:notice] = "you can't edit other user's profile"
     redirect_to user_path(@user)
    end
  end

  def update
    if @user.update_attributes(users_params)
    flash[:notice] = "user was scuccessfully updated"
    redirect_to user_path(current_user)
    else
    flash.now[:alert] ="user was failed to update"
    render :edit
    end
  end

  def posts
    @posts = @user.posts.filter_by_reviewed_status(current_user).where(is_draft: false).page(params[:page]).per(20)
    render :layout => false
  end

  def drafts
    @drafts = @user.posts.where(is_draft: true).page(params[:page]).per(20)
    render :layout => false
  end

  def replies
    @replies = @user.replies
    render :layout => false
  end

  def collects
    @collects = @user.collected_posts
    render :layout => false
  end

  def friend_list
    @friend_list = @user.all_friends
    @firend_replies = @user.inverse_friends
    @firend_responses = @user.friendships.where(:is_confirm => false)
    render :layout => false
  end

  def accept
   reply_user = @user.inverse_friends.where(user_id: params[:user_id]).first
   reply_user.update_attributes(is_confirm: true)
   @friendship = current_user.friendships.build(friend_id: params[:user_id],is_confirm: true)
   @friendship.save
   redirect_back(fallback_location: user_path(@user))
  end

  def ignore
   reply_user = @user.inverse_friends.where(user_id: params[:user_id])
   reply_user.destroy_all
   redirect_back(fallback_location: user_path(@user))
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end

  def users_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
end
