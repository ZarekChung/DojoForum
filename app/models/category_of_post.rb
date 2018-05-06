class CategoryOfPost < ApplicationRecord
  belongs_to :post
  belongs_to :category

  def update_category(post,category_id,id)
    CategoryOfPost.where(post: post , category_id: category_id).first_or_create do |category_of_posts|
      category_of_posts.post = post
      category_of_posts.category_id = category_id
    end

  end
end
