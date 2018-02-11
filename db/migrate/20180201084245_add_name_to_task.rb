class AddNameToTask < ActiveRecord::Migration[5.1]
  def change
    change_table :tasks do |t|
      t.string :name, default: '', null: false
    end
  end
end
