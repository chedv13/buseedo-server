class AddIsDefaultToTask < ActiveRecord::Migration[5.1]
  def change
    change_table :tasks do |t|
      t.boolean :is_default, default: false, null: false
    end
  end
end