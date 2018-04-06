class RemoveUserFromUserTasks < ActiveRecord::Migration[5.1]
  def up
    remove_reference :user_tasks, :user
  end

  def down
    add_reference :user_tasks, :user, index: true
    UserTask.find_each do |ut|
      ut.update_attribute!(:user_id, User.find_by(id: ut.course_user.user_id).id)
    end
    change_column_null(:user_tasks, :user_id, false )
  end
end
