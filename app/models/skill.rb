class Skill < ApplicationRecord
  has_and_belongs_to_many :tasks

  validates :name, uniqueness: true, presence: true
end
