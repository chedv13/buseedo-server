class Level < ApplicationRecord
  has_many :users

  validates :number, presence: true, uniqueness: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }
  validates :required_number_of_points, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
