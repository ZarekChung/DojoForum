class RepliesController < ApplicationController
  before_action :set_post
  before_action :set_reply, only: [:destroy,:edit,:update]
  def create
    @reply = @post.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    current_user.update_attributes(replies_count: current_user.replies.count)
    redirect_to post_path(@post)
  end

  def destroy
    #if current_user.admin?
      @reply.destroy
      redirect_to post_path(@post)
    #end
  end

  def edit
    render :layout => false
  end

  def update
    if @reply.update_attributes(reply_params)
      flash[:notice] = "Reply was scuccessfully updated"
      redirect_to post_path(@post)
    else
      flash.now[:alert] ="Reply was failed to update"
      render :edit
    end
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
   params.require(:reply).permit(:content)
 end
end
