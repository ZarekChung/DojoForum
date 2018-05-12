class FriendsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save
      #flash 會留到下一個request
      flash[:notice] = "friendship was scuccessfully created"
      redirect_back(fallback_location: root_path)
    else
      #flash.now 只存在現在這個request
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @friendship.destroy
    flash[:alert] = "friendship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
