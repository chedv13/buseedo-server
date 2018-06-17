class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user_day
  has_many :decisions, class_name: 'Decision', dependent: :destroy, inverse_of: :user_task
  has_many :intervals, class_name: 'UserTaskInterval', dependent: :destroy, inverse_of: :user_task

  after_save :set_last_interval_finished_if_is_completed
  after_save :update_user_day_and_create_user_task
  before_save :set_user_task_as_current

  private

  def set_last_interval_finished_if_is_completed
    intervals.last.update_attributes!(finished_at: Time.zone.now) if is_completed
  end

  def set_user_task_as_current
    is_new_record = new_record?

    if is_current || is_new_record
      prev_current_user_task = UserTask.joins(user_day: :course_user).where(
        "course_users.id = #{user_day.course_user.id} AND user_tasks.is_current = TRUE AND task_id != #{task.id}"
      ).first
      prev_current_user_task.update_attribute(:is_current, false) if prev_current_user_task
      self.is_current = true if new_record?
    end
  end

  def update_user_day_and_create_user_task
    if is_completed and is_completed_changed?
      course_user = user_day.course_user
      course_user.update_column(:current_number_of_points, course_user.current_number_of_points + task.number_of_points)

      user_tasks = user_day.user_tasks
      if user_tasks.length == user_tasks.where(is_completed: true)
        user_day.update_attribute(:is_completed, true)
      end

      return if user_day.is_completed

      next_task = user_day.day.tasks.find_by(serial_number: task.serial_number + 1)
      user_day.user_tasks.create!(task: next_task) if next_task
    end
  end
end
