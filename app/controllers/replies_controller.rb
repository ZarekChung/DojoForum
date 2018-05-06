class RepliesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.build(reply_params)
    @reply.user = User.all.sample
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

  def reply_params
   params.require(:reply).permit(:content)
 end
end
