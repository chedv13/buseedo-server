class UserTaskInterval < ApplicationRecord
  SYSTEM_DATETIME_FIELDS = %i[started_at finished_at].freeze

  belongs_to :user_task

  # validate :interval_should_not_create_if_previous_interval_finished_at_is_nil, if: proc { user_task }
  # validate :interval_should_not_create_if_user_task_is_completed, if: proc { user_task }

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
  #
  # private
  #
  # def interval_should_not_create_if_previous_interval_finished_at_is_nil
  #   unless user_task.intervals.last.finished_at
  #     errors.add(:base, 'Interval should not be exist if previous interval finished_at is nil')
  #   end
  # end
  #
  # def interval_should_not_create_if_user_task_is_completed
  #   if user_task.is_completed
  #     errors.add(:base, 'Interval should not be exist if user task is completed')
  #   end
  # end
end
