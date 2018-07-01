class AddAdditionalColumnToDecisions < ActiveRecord::Migration[5.1]
  def change
    change_table :decisions do |t|
      t.integer :teacher_id, index: true
      t.text :feedback
    end
  end
end
