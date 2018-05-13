class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, :except => [:index]
  def index
   @posts = Post.all
 end

 def show
    @post = Post.find_by(id: params[:id])
    if !@post
      render json: {
        message: "Can't find the posts!",
        status: 400
      }
    else
     render "api/v1/posts/show"
    end
  end

  def create
     @post = Post.new(post_params)
     @post.user = current_user
     @post.is_draft = false
     if @post.save
       @post.category_of_posts.create!(post: @post, category_id: Category.first.id,is_checked:true)
       render json: {
         message: "post created successfully!",
         result: @post
       }
     else
       render json: {
         errors: @post.errors
       }
     end
   end

   def update
      @post = Post.find_by(id: params[:id])
      if @post.update(post_params)
        render json: {
          message: "Post updated successfully!",
          result: @post
        }
      else
        render json: {
          errors: @post.errors
        }
      end
    end

   def destroy
   @post = Post.find_by(id: params[:id])
   @post.destroy
   render json: {
     message: "Post destroy successfully!"
   }
 end

   private

   def post_params
     params.permit(:title,:article,:privacy_id,:photo)

   end

end
