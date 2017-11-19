class Skill < ApplicationRecord
  has_and_belongs_to_many :tasks

  validates :importance, presence: true, uniqueness: true, numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1
  }
  validates :name, presence: true, uniqueness: true
end
