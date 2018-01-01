class DayTask < ApplicationRecord
  MAX_NUMBER_OF_PERCENTAGES = 100

  belongs_to :day
  belongs_to :task

  validates :number_of_percentages, presence: true, numericality: { only_integer: true }
  validate :number_of_percentages_sum_cannot_be_more_than_100_by_day

  def self.default
    DayTask.joins(:task).find_by('tasks.is_default = true')
  end

  def next_by_task_id
    DayTask.where("task_id > #{task_id}").order(:task_id).first
  end

  private

  def number_of_percentages_sum_cannot_be_more_than_100_by_day
    number_of_percentages_sum = day.tasks.sum(:number_of_percentages)

    if number_of_percentages_sum + task.number_of_percentages > MAX_NUMBER_OF_PERCENTAGES
      errors.add(:day, "max number of percentages should be less or equal #{MAX_NUMBER_OF_PERCENTAGES}")
    end
  end
end
