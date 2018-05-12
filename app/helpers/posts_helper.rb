module PostsHelper
  def get_category?(category_id,post)
  CategoryOfPost.where(post: post,category_id: category_id,is_checked: true).exists?
  end

  def check_privacty?(post)
    if post.privacy == Privacy.last
      post.is_private?(current_user)
    elsif post.privacy == Privacy.find(2)
      post.is_friendOnly?(current_user)
    else
      true
    end

  end
end
