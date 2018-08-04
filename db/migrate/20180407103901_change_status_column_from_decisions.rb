class ChangeStatusColumnFromDecisions < ActiveRecord::Migration[5.1]
  def up
    change_column_default(:decisions, :status, 0)
  end

  def down
    change_column_default(:decisions, :status, nil)
  end
end
