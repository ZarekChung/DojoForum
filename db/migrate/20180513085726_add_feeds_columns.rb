class AddFeedsColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :replies_count, :integer
  end
end
