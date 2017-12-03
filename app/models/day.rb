class Day < ApplicationRecord
  has_many :day_tasks
  has_many :tasks, through: :day_tasks

  validates :number, presence: true
end
