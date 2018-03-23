class AddCoverColumnsToCourses < ActiveRecord::Migration[5.1]
  def up
    add_attachment :courses, :cover
  end

  def down
    remove_attachment :courses, :cover
  end
end
