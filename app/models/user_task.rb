class UserTask < ApplicationRecord
  belongs_to :day_task
  belongs_to :user
  has_many :decisions, class_name: 'Decision', dependent: :destroy, inverse_of: :user_task
  has_many :intervals, class_name: 'UserTaskInterval', dependent: :destroy, inverse_of: :user_task

  validates :day_task_id, uniqueness: { scope: :user_id }

  after_save :set_last_interval_finished_if_is_completed

  def d
    query = %{
      SELECT
        id,
        body,
        (
          SELECT user_task_id
          FROM decisions
          WHERE user_task_id = user_tasks.id AND (status ISNULL OR status = 0)
          ORDER BY decisions.id DESC
          LIMIT 1
        )
      FROM user_tasks
      WHERE user_id = #{user.id}
      LIMIT 1;
    }

    UserTask.find_by_sql(query)
  end

  private

  def set_last_interval_finished_if_is_completed
    intervals.last.update_attributes!(finished_at: Time.zone.now) if is_completed
  end
end
