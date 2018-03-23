class CourseUser < ApplicationRecord
  belongs_to :course
  belongs_to :user

  after_create :create_default_user_task

  def first_task
    course.tasks.find_by(serial_number: 1)
  end

  private

  def create_default_user_task
    user.user_tasks.create!(task: first_task)
  end
end
