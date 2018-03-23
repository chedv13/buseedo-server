class CreateDecisions < ActiveRecord::Migration[5.1]
  def change
    create_table :decisions do |t|
      t.integer :status, null: false
      t.text :body, null: false

      t.belongs_to :user_task, index: true, null: false

      t.timestamps
    end
  end
end
