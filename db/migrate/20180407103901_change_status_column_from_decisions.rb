class ChangeStatusColumnFromDecisions < ActiveRecord::Migration[5.1]
  def change
    change_column :decisions, :status, :integer, null: false, default: 0
  end
end
