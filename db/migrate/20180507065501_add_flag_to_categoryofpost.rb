class AddFlagToCategoryofpost < ActiveRecord::Migration[5.1]
  def change
    add_column :category_of_posts, :is_checked, :boolean, default: false
  end
end
