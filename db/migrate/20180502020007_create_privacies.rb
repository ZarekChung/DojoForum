class CreatePrivacies < ActiveRecord::Migration[5.1]
  def change
    create_table :privacies do |t|
      t.string   :name 
      t.timestamps
    end
  end
end
