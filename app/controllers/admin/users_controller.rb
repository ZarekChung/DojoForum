class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.save
      redirect_to admin_users_path
      flash[:notice] = "user was successfully created"
    else
      render :index
    end
  end

  def user_params
    params.require(:user).permit(:role)
  end
end
