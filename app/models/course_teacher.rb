class CourseTeacher < ApplicationRecord
  belongs_to :course
  belongs_to :teacher, class_name: 'User', foreign_key: :user_id
end
