class CreateUserTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_tasks do |t|
      t.datetime :started_at
      t.datetime :finished_at

      t.belongs_to :user, index: true, null: false
      t.belongs_to :day_task, index: true, null: false

      t.timestamps
    end
  end
end
