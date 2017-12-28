class UserTask < ApplicationRecord
  belongs_to :day_task
  belongs_to :user

  ['finished_at', 'started_at'].each do |timestamp_field_name|
    define_method("#{timestamp_field_name}_seconds_since_1970") do
      timestamp_field = send(timestamp_field_name)
      timestamp_field ? timestamp_field.strftime('%s').to_i : nil
    end
  end
end
