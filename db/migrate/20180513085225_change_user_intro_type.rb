class ChangeUserIntroType < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :intro, :text
  end
end
