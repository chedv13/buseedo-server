class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :course_user
  has_many :decisions, class_name: 'Decision', dependent: :destroy, inverse_of: :user_task
  has_many :intervals, class_name: 'UserTaskInterval', dependent: :destroy, inverse_of: :user_task

  validates :task_id, uniqueness: { scope: :course_user_id }

  after_save :set_current_number_of_points_to_course_user
  after_save :set_last_interval_finished_if_is_completed

  # def next_declined_or_unresolved_task
  #   query = %{
  #     SELECT
  #       id,
  #       body,
  #       (
  #         SELECT user_task_id
  #         FROM decisions
  #         WHERE user_task_id = user_tasks.id AND (status ISNULL OR status = 0)
  #         ORDER BY decisions.id DESC
  #         LIMIT 1
  #       )
  #     FROM user_tasks
  #     WHERE user_id = #{user.id}
  #     LIMIT 1;
  #   }
  #
  #   UserTask.find_by_sql(query)
  # end

  private

  def set_last_interval_finished_if_is_completed
    intervals.last.update_attributes!(finished_at: Time.zone.now) if is_completed
  end

  def set_current_number_of_points_to_course_user
    if is_completed
      course_user.update_attributes!(current_number_of_points: course_user.current_number_of_points + task.number_of_points)
    end
  end
end
