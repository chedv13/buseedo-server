class CourseUser < ApplicationRecord
  SYSTEM_DATETIME_FIELDS = %i[continued_at created_at].freeze

  belongs_to :course
  belongs_to :user
  has_many :user_tasks

  validates :user_id, uniqueness: { scope: :is_current, message: 'user_id with is_current should be unique' }, if: proc { is_current }

  after_create :create_default_user_task
  before_create :set_continued_at
  before_validation :set_course_user_as_current

  CourseUser::SYSTEM_DATETIME_FIELDS.each do |timestamp_field_name|
    define_method("#{timestamp_field_name}_seconds_since_1970") do
      timestamp_field = send(timestamp_field_name)
      timestamp_field ? timestamp_field.strftime('%s').to_i : nil
    end
  end

  private

  def create_default_user_task
    user_tasks.create!(task: course.days.first.tasks.first)
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
