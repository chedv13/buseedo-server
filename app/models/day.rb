class Day < ApplicationRecord
  belongs_to :course
  has_many :tasks, -> { order 'serial_number ASC' }, dependent: :destroy

  validates :number, presence: true
  validates :number, uniqueness: { scope: :course_id, message: 'number with course_id should be unique' }

  def prev
    course.days.find_by(number: number - 1)
  end
end
