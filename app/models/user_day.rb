class UserDay < ApplicationRecord
  belongs_to :course_user
  belongs_to :day
  has_many :user_tasks

  after_create :create_first_user_task
  after_save :create_next_day
  before_create :set_default_started_at

  def prev
    course_user.user_days.find_by(day: day.prev)
  end

  def started_at_seconds_since_1970
    started_at.to_i
  end

  def status
    user_task_statuses = user_tasks.map { |x| x.decisions.empty? ? nil : x.decisions.last.status }.compact

    if user_task_statuses.include?('failed')
      'failed'
    elsif user_task_statuses.empty? || user_task_statuses.include?('pending')
      'pending'
    else
      'verified'
    end
  end

  private

  def create_first_user_task
    user_tasks.create!(task: day.tasks.first, is_current: true)
  end

  def set_default_started_at
    prev_user_day = prev
    self.started_at = prev_user_day ? prev_user_day.started_at + 1.day : Time.zone.now
  end

  def create_next_day
    if is_completed && (new_record? || saved_change_to_is_completed?)
      next_day = day.course.days.find_by(number: day.number + 1)
      course_user.user_days.create!(day: next_day) if next_day
    end
  end
end
