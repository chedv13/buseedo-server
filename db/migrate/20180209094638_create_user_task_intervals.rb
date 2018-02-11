class CreateUserTaskIntervals < ActiveRecord::Migration[5.1]
  def change
    create_table :user_task_intervals do |t|
      t.boolean :is_finishing, default: false
      t.integer :value, default: 0, null: false

      t.belongs_to :user_task, index: true

      t.timestamps
    end
  end
end
