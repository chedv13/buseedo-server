class Task < ApplicationRecord
  belongs_to :day
  has_many :skill_tasks, dependent: :destroy
  has_many :skills, through: :skill_tasks

  validates :body, :name, :number_of_points, :number_of_percentages, :serial_number, presence: true
end
