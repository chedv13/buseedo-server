class CreateCourseTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :course_teachers do |t|
      t.boolean :is_creator, default: false

      t.belongs_to :course, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
