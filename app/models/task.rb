class Task < ApplicationRecord
  has_many :days, through: :day_tasks
  has_many :day_tasks
  has_and_belongs_to_many :skills

  validates :body, presence: true, uniqueness: true
  validates :number_of_points, presence: true
  validates :number_of_percentages, presence: true
end
