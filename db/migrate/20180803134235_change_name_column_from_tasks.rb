class ChangeNameColumnFromTasks < ActiveRecord::Migration[5.1]
  def up
    change_column_null(:tasks, :name, true)
  end

  def down
    change_column_null(:tasks, :name, false)
  end
end