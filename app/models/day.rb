class Day < ApplicationRecord
  belongs_to :course
  has_many :tasks, -> { order 'serial_number ASC' }, dependent: :destroy

  validates :number, presence: true
end
