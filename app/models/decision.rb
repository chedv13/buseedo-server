class Decision < ApplicationRecord
  enum status: %i[pending declined verified]

  belongs_to :user_task

  before_save :set_user_task_to_completed

  def as_json(*)
    {
      body: body,
      id: id,
      user_task_id: user_task_id
    }
  end

  private

  def set_user_task_to_completed
    user_task.update_attributes!(is_completed: true)
  end
end
