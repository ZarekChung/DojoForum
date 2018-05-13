class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, :except => [:index]
  def index
   @posts = Post.all
   #render json: @posts
   render json: {
     data: @posts.map do |post|
       {
         title: post.title,
         article: post.article,
         photo: post.photo,
         privacy_id: post.privacy_id,
         categories: post.categories,
         replies_count: post.replies_count,
         view_count: post.view_count,
         user_id: post.user_id,
         is_draft: post.is_draft

        }
     end
   }
 end

 def show
    @post = Post.find_by(id: params[:id])
    if !@post
      render json: {
        message: "Can't find the posts!",
        status: 400
      }
    else
      render json: {
        title: @post.title,
        article: @post.article,
        photo: @post.photo,
        privacy_id: @post.privacy_id,
        categories: @post.categories,
        replies_count: @post.replies_count,
        view_count: @post.view_count,
        user_id: @post.user_id,
        is_draft: @post.is_draft
      }
    end
  end
end
