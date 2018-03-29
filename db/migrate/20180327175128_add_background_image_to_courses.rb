class AddBackgroundImageToCourses < ActiveRecord::Migration[5.1]
  def up
    add_attachment :courses, :background_image
  end

  def down
    remove_attachment :courses, :background_image
  end
end
