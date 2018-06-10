class User < ApplicationRecord
  enum category: %i[customer teacher]

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable

  include DeviseTokenAuth::Concerns::User

  has_attached_file :avatar,
                    default_url: '/images/users/avatars/:style/missing.png',
                    styles: { common_80: '80x80>', common_120: '120x120>' },
                    url: '/system/users/avatars/:id/:style/:basename',
                    use_timestamp: false
  validates_attachment_content_type :avatar,
                                    content_type: %r{^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$},
                                    message: 'file type is not allowed (only jpeg/png/gif images)'

  belongs_to :level
  has_many :course_teachers
  has_many :courses_for_teaching, through: :course_teachers, source: :course
  has_many :course_users, dependent: :destroy
  has_many :courses_for_education, through: :course_users, source: :course
  has_many :user_days
  # has_many :user_tasks, -> { order 'id DESC' }, through: :course_users

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

  def current_course
    course_users.find_by(is_current: true)
  end

  def current_user_task
    user_tasks.find_by(is_current: true)
  end

  def to_s
    email
  end

  def as_json(*)
    {
      # TODO: Выбор аватар получать из аргументов
      avatar_url: avatar.url(:common_80, timestamp: false),
      academic_degree: academic_degree,
      country: country,
      current_number_of_points: current_number_of_points,
      dream_job: dream_job,
      educational_institution: educational_institution,
      email: email,
      gender: gender,
      hobby: hobby,
      id: id,
      is_first_filling_passed: is_first_filling_passed,
      name: name,
      year_of_ending_of_educational_institution: year_of_ending_of_educational_institution
    }
  end

  def current_day_user_task_json_objects(current_day)
    UserTask.joins(day_task: %i[day task]).select(
      'body, user_tasks.id, is_completed, name, number_of_percentages, number_of_points, tasks.id AS task_id'
    ).where("user_id = #{id} and number = #{current_day.number}").map do |x|
      {
        body: x.body,
        id: x.id,
        intervals: x.intervals.map(&:as_json),
        is_completed: x.is_completed,
        name: x.name,
        number_of_percentages: x.number_of_percentages,
        number_of_points: x.number_of_points,
        skills: Task.find(x.task_id).skills.map(&:as_json)
      }
    end
  end

  def token_validation_response
    result = as_json
    result[:level] = {
      id: level.id,
      number: level.number,
      required_number_of_points: level.required_number_of_points
    }

    # TODO: Подумать надо ли это вообще передавать?
    previous_level = level.number > 1 ? Level.find_by(number: level.number - 1).required_number_of_points : nil
    result['previous_required_number_of_points'] = previous_level ? previous_level.required_number_of_points : 0

    result
  end

  private

  def set_level
    update_attribute(:level, Level.where('required_number_of_points <= ?', current_number_of_points)
                               .order('required_number_of_points DESC').first)
  end
end
