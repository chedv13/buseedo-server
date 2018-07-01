class Task < ApplicationRecord
  MAX_NUMBER_OF_PERCENTAGES = 100

  belongs_to :day
  has_many :skill_tasks, dependent: :destroy
  has_many :skills, through: :skill_tasks

  validates :name, :number_of_points, :number_of_percentages, :serial_number, presence: true
  validates :number_of_percentages, numericality: { greater_than: 0, only_integer: true, less_than_or_equal_to: MAX_NUMBER_OF_PERCENTAGES }
  validates :number_of_points, numericality: { greater_than: 0, only_integer: true }
  validates :serial_number, uniqueness: { scope: :day_id, message: 'serial_number with day_id should be unique' }

  after_save :increase_course_final_number_of_points
  after_save :update_skills_from_course

  private

  def update_skills_from_course
    course = day.course
    query = %Q{
      select
        name,
        count(name)
      from skill_tasks
        inner join skills on skill_tasks.skill_id = skills.id
      where task_id in (
        select tasks.id
        from courses
          inner join days on courses.id = days.course_id
          inner join tasks on days.id = tasks.day_id
        where course_id = 1
      )
      group by name
      order by count(name) desc;
    }
    records_array = ActiveRecord::Base.connection.execute(query)
    course.update_attribute(:skills, records_array.inject({}) { |m, e| m[e['name']] = e['count']; m })
  end

  def increase_course_final_number_of_points
    if is_published_changed?
      course = day.course
      final_number_of_points = course.final_number_of_points
      final_number_of_points = is_published ? (final_number_of_points + number_of_points) : (final_number_of_points - number_of_points)
      course.update_attribute(:final_number_of_points, final_number_of_points)
    end
  end
end
