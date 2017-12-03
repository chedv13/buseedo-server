class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable

  include DeviseTokenAuth::Concerns::User

  has_attached_file :avatar,
                    styles: { ios_common: '80x80>' },
                    url: '/system/users/avatars/:id/:style/:basename',
                    default_url: '/images/users/avatars/:style/missing.png'
  validates_attachment_content_type :avatar,
                                    content_type: %r{^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$},
                                    message: 'file type is not allowed (only jpeg/png/gif images)'

  belongs_to :level, required: true
  has_many :user_tasks, -> { order 'id DESC' }
  has_many :day_tasks, through: :user_tasks
  has_many :days, through: :day_tasks
  has_many :tasks, through: :day_tasks

  after_save :set_level
  before_validation(on: :create) do
    self.level = Level.find_by(number: 1)
  end

  def self.avatar(style = 'original')
    query = <<HERE
      COALESCE(
        get_users_avatar_url(users.id :: INT, '#{style}', avatar_file_name),
        '/images/users/#{style}/missing.png'
       ) AS avatar
HERE
    query
  end

  def current_task
    user_tasks.last
  end

  def to_s
    email
  end

  # TODO: Здесь добавить logger.error на не
  def token_validation_response
    # current_task = self.current_task
    current_level_number = level.number
    result = {
        avatar_url: avatar.url(:ios_common, timestamp: false),
        current_number_of_points: current_number_of_points,
        email: email,
        level: {
            number: current_level_number,
            required_number_of_points: level.required_number_of_points
        },
        name: name

    }
    previous_level = level.number > 1 ? Level.find_by(number: level.number - 1).required_number_of_points : nil
    result['previous_required_number_of_points'] = previous_level ? previous_level.required_number_of_points : 0
    result
  end

  private

  def set_level
    update_attribute(:level, Level.where('required_number_of_points <= ?', current_number_of_points).
        order('required_number_of_points DESC').first)
  end
end
