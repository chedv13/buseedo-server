class CreateCourseUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :course_users do |t|
      t.integer :current_number_of_points, default: 0, null: false
      t.boolean :is_completed, default: false, null: false
      t.boolean :is_current, default: false, null: false

      t.belongs_to :course, index: true, null: false
      t.belongs_to :user, index: true, null: false

      t.timestamps
    end
  end
end
