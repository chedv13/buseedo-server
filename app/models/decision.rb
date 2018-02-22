class Decision < ApplicationRecord
  belongs_to :user_task

  enum status: %i[declined verified]

  def as_json(*)
    {
      body: body,
      id: id,
      user_task_id: user_task_id
    }
  end
end
