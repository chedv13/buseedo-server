class Level < ApplicationRecord
  has_many :users

  validates :number, presence: true, uniqueness: true
  validates :required_number_of_points, presence: true
end
