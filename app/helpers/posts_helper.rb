module PostsHelper
  def get_category?(category_id,post)
  CategoryOfPost.where(post: post,category_id: category_id).exists?
  end
end
