class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  belongs_to :level, required: false
  has_many :days, -> { order 'id DESC' }
  has_many :tasks, through: :days

  def to_s
    self.email
  end
end
