class UserTask < ApplicationRecord
  belongs_to :day_task
  belongs_to :user
end
