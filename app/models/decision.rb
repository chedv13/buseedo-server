class Decision < ApplicationRecord
  enum status: %i[pending failed verified]

  belongs_to :teacher, class_name: 'User', foreign_key: :teacher_id, primary_key: :id
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