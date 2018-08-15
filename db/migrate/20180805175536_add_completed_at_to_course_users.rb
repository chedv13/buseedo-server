class AddCompletedAtToCourseUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :course_users, :completed_at, :datetime
  end
end
