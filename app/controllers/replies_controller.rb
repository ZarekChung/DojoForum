class RepliesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @reply = Reply.find(params[:id])
    #if current_user.admin?
      @reply.destroy
      redirect_to post_path(@post)
    #end
  end

  def edit
    @post = Post.find(params[:post_id])
    @reply = Reply.find(params[:id])
    render :layout => false
  end

  def update
    @post = Post.find(params[:post_id])
    @reply = Reply.find(params[:id])
    if @reply.update_attributes(reply_params)
      flash[:notice] = "Reply was scuccessfully updated"
      redirect_to post_path(@post)
    else
      flash.now[:alert] ="Reply was failed to update"
      render :edit
    end
  end

  def reply_params
   params.require(:reply).permit(:content)
 end
end
