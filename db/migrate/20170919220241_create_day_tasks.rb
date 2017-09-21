class CreateDayTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :day_tasks do |t|
      t.datetime :started_at
      t.datetime :finished_at

      t.belongs_to :task, index: true, null: false
      t.belongs_to :day, index: true, null: false

      t.timestamps
    end
  end
end
