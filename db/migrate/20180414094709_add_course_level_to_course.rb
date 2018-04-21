class AddCourseLevelToCourse < ActiveRecord::Migration[5.1]
  def change
    change_table :courses do |t|
      t.belongs_to :course_level, index: true
    end
  end
end
