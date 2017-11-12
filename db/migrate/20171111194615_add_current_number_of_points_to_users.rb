class AddCurrentNumberOfPointsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.integer :current_number_of_points, default: 0, null: false
    end
  end
end
