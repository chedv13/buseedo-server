class AddImportanceToSkills < ActiveRecord::Migration[5.1]
  def change
    change_table :skills do |t|
      t.integer :importance, null: false
    end
  end
end
