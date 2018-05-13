class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @categories = Categories.all

  end
end
