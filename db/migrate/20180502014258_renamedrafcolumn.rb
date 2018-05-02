class Renamedrafcolumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts ,:is_draff ,:is_draft
  end
end
