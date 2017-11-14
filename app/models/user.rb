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
  has_many :days, -> { order 'id DESC' }
  has_many :tasks, through: :days

  def self.avatar(style = 'original')
    query = <<HERE
      COALESCE(
        get_users_avatar_url(users.id :: INT, '#{style}', avatar_file_name),
        '/images/users/#{style}/missing.png'
       ) AS avatar
HERE
    query
  end

  def to_s
    self.email
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
    previous_level = Level.find_by(number: level.number - 1).required_number_of_points ? level.number > 1 : nil
    result['previous_required_number_of_points'] = previous_level.required_number_of_points ? previous_level : 0
    result
  end
end
