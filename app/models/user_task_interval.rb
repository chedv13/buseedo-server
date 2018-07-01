class UserTaskInterval < ApplicationRecord
  SYSTEM_DATETIME_FIELDS = %i[started_at finished_at].freeze

  belongs_to :user_task

  UserTaskInterval::SYSTEM_DATETIME_FIELDS.each do |timestamp_field_name|
    define_method("#{timestamp_field_name}_seconds_since_1970") do
      timestamp_field = send(timestamp_field_name)
      timestamp_field ? timestamp_field.strftime('%s').to_i : nil
    end
  end

  def as_json(*)
    {
      id: id,
      finished_at: finished_at_seconds_since_1970,
      started_at: started_at_seconds_since_1970,
      user_task_id: user_task.id
    }
  end
end
