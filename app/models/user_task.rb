class UserTask < ApplicationRecord
  belongs_to :day_task
  belongs_to :user
  has_many :decisions, class_name: 'Decision', dependent: :destroy, inverse_of: :user_task
  has_many :intervals, class_name: 'UserTaskInterval', dependent: :destroy, inverse_of: :user_task

  validates :day_task_id, uniqueness: { scope: :user_id }

  after_save :set_last_interval_finished_if_is_completed

  # def as_json(*)
  #   super.except('created_at', 'updated_at').tap do |hash|
  #     # hash["is_single_day_¬event"] = single_day_event?
  #   end
  # end

  private

  def set_last_interval_finished_if_is_completed
    intervals.last.update_attributes!(finished_at: Time.zone.now) if is_completed
  end
end
