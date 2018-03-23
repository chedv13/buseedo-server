class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.boolean :is_published, default: false, null: false
      t.integer :number_of_percentages, null: false
      t.integer :number_of_points, null: false
      t.integer :serial_number, null: false
      t.string :name, null: false
      t.text :body, null: false

      t.belongs_to :day, index: true, null: false

      t.timestamps
    end
  end
end
