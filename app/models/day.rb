class Day < ApplicationRecord
  belongs_to :course
  has_many :tasks, dependent: :destroy

  validates :number, presence: true
end
