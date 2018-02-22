class CreateDecisions < ActiveRecord::Migration[5.1]
  def change
    create_table :decisions do |t|
      t.integer :status
      t.text :body, null: false

      t.belongs_to :user_task, index: true

      t.timestamps
    end
  end
end
