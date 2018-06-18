class ChangeBodyColumnFromTasks < ActiveRecord::Migration[5.1]
  def change
    change_column_null(:tasks, :body, true)
  end
end
