class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.text :body, null: false
      t.integer :number_of_points, null: false
      t.integer :number_of_percentages, null: false

      t.timestamps
    end
  end
end
