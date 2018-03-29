class AddCategoryToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.integer :category, default: 0, null: false
    end
  end
end
