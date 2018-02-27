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
  has_many :user_tasks, -> { order 'id DESC' }, dependent: :destroy, inverse_of: :user
  has_many :day_tasks, through: :user_tasks
  has_many :days, through: :day_tasks
  has_many :tasks, through: :day_tasks

  after_create :create_default_task
  after_create :set_level
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

  def current_user_task
    user_tasks.first
  end

  def to_s
    email
  end

  def token_validation_response
    user_task = current_user_task
    current_day_task = user_task.day_task
    current_day = current_day_task.day
    current_task = current_day_task.task
    result = {
      avatar_url: avatar.url(:ios_common, timestamp: false),
      day: {
        count: current_day.tasks.count,
        id: current_day.id,
        number: current_day.number
      },
      current_number_of_points: current_number_of_points,
      user_task: {
        body: current_task.body,
        id: user_task.id,
        intervals: user_task.intervals.map(&:as_json),
        is_completed: user_task.is_completed,
        name: current_task.name,
        number_of_percentages: current_day_task.number_of_percentages,
        number_of_points: current_task.number_of_points,
        skills: current_task.skills.map(&:as_json)
      },
      email: email,
      id: id,
      level: {
        id: level.id,
        number: level.number,
        required_number_of_points: level.required_number_of_points
      },
      name: name
    }
    previous_level = level.number > 1 ? Level.find_by(number: level.number - 1).required_number_of_points : nil
    result['previous_required_number_of_points'] = previous_level ? previous_level.required_number_of_points : 0
    result
  end

  private

  def create_default_task
    user_tasks.create(day_task: DayTask.default) unless tasks.exists?(is_default: true)
  end

  def set_level
    update_attribute(:level, Level.where('required_number_of_points <= ?', current_number_of_points)
                               .order('required_number_of_points DESC').first)
  end
end
