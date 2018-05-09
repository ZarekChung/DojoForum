class UsersController < ApplicationController
  before_action :set_user, only: [:drafts,:posts,:show,:edit, :update]

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
    @posts = @user.posts.where(is_draft: false).page(params[:page]).per(20)
    render :layout => false
  end

  def drafts
    @drafts = @user.posts.where(is_draft: true).page(params[:page]).per(20)
    render :layout => false
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end

  def users_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
end
