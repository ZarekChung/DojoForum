class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string  :title
      t.text    :article
      t.string  :photo
      t.integer :privacy_id
      t.string  :categories
      t.integer :replies_count
      t.integer :view_count
      t.integer :user_id
      t.boolean :is_draff , default: true

      t.timestamps
    end
  end
end
