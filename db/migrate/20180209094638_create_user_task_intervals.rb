class CreateUserTaskIntervals < ActiveRecord::Migration[5.1]
  def change
    create_table :user_task_intervals do |t|
      t.datetime :started_at, null: false
      t.datetime :finished_at

      t.belongs_to :user_task, index: true, null: false

      t.timestamps
    end
  end
end
