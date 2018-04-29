class CourseUser < ApplicationRecord
  SYSTEM_DATETIME_FIELDS = %i[continued_at created_at].freeze

  belongs_to :course
  belongs_to :user
  has_many :user_tasks

  after_create :create_default_user_task
  before_create :set_continued_at
  before_save :set_course_user_as_current

  CourseUser::SYSTEM_DATETIME_FIELDS.each do |timestamp_field_name|
    define_method("#{timestamp_field_name}_seconds_since_1970") do
      timestamp_field = send(timestamp_field_name)
      timestamp_field ? timestamp_field.strftime('%s').to_i : nil
    end
  end

  def first_task
    course.tasks.find_by(serial_number: 1)
  end

  private

  def create_default_user_task
    user_tasks.create!(task: first_task)
  end

  def set_continued_at
    self.continued_at = Time.zone.now
  end

  def set_course_user_as_current
    self.is_current = true if new_record?
    if is_current
      course_user = CourseUser.find_by("#{new_record? ? "" : "id != #{id} AND "}  is_current = true AND user_id = #{user.id}")
      course_user.update_attributes!(is_current: false) if course_user
    end
  end
end
