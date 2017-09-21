class CreateLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :levels do |t|
      t.integer :number, null: false
      t.integer :required_number_of_points, null: false

      t.timestamps
    end
  end
end
