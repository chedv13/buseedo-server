class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable

  include DeviseTokenAuth::Concerns::User

  has_attached_file :avatar,
                    styles: { cover: '200x200>', catalogue: '100x100>' },
                    url: '/system/users/avatars/:id/:style/:basename',
                    default_url: '/images/users/avatars/:style/missing.png'
  validates_attachment_content_type :avatar,
                                    content_type: %r{^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$},
                                    message: 'file type is not allowed (only jpeg/png/gif images)'

  belongs_to :level, required: false
  has_many :user_tasks, -> { order 'id DESC' }
  has_many :day_tasks, through: :user_tasks
  has_many :days, through: :day_tasks
  has_many :tasks, through: :day_tasks

  def self.avatar(style = 'original')
    query = <<HERE
      COALESCE(
        get_users_avatar_url(users.id :: INT, '#{style}', avatar_file_name),
        '/images/users/#{style}/missing.png'∆
       ) AS avatar
HERE
    query
  end

  def current_task
    user_tasks.first.day_task.task
  end

  def to_s
    email
  end

  # TODO: Здесь добавить logger.error на не
  def token_validation_response
    current_level_number = level.number
    result = {
        avatar_url: avatar.url(:cover, timestamp: false),
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
end
