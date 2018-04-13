class Decision < ApplicationRecord
  enum status: %i[created declined verified]

  belongs_to :user_task

  def as_json(*)
    {
      body: body,
      id: id,
      user_task_id: user_task_id
    }
  end
end
