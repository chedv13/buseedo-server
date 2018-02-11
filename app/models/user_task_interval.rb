class UserTaskInterval < ApplicationRecord
  belongs_to :user_task

  validates :user_task_id, uniqueness: { scope: :is_finishing }, if: -> { is_finishing }

  before_save :set_finished_at_to_user_task, if: proc { |i| i.is_finishing }

  private

  def set_finished_at_to_user_task
    user_task.update_attributes!(finished_at: Time.now)
  end
end
