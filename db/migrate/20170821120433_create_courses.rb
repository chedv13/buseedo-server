class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.boolean :is_published, default: false, null: false
      t.datetime :published_at
      t.datetime :unpublished_at
      t.integer :final_number_of_points, default: 0, null: false
      t.integer :rating, default: 0, null: false
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
