class AddFullDescriptionToCourses < ActiveRecord::Migration[5.1]
  def change
    change_table :courses do |t|
      t.text :full_description
    end
  end
end
