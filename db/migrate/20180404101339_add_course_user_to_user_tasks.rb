class AddCourseUserToUserTasks < ActiveRecord::Migration[5.1]
  def up
    add_reference :user_tasks, :course_user, index: true
    UserTask.find_each do |ut|
      course_id = ut.task.day.course.id
      user_id = ut.user_id
      ut.update_attribute(:course_user_id, CourseUser.find_by(course_id: course_id, user_id: user_id).id)
    end
    change_column_null(:user_tasks, :course_user_id, false )
  end

  def down
    remove_reference :user_tasks, :course_user
  end
end
