class Skill < ApplicationRecord
  has_many :skill_tasks, dependent: :destroy
  has_many :tasks, through: :skill_tasks

  validates :name, presence: true, uniqueness: true

  def as_json
    {
      id: id,
      name: name
    }
  end
end
