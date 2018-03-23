class CreateUserTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_tasks do |t|
      t.boolean :is_completed, default: false, null: false
      t.boolean :is_current, default: false, null: false

      t.belongs_to :user, index: true, null: false
      t.belongs_to :task, index: true, null: false

      t.timestamps
    end
  end
end
