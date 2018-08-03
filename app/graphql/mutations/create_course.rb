require 'rmagick'

Mutations::CreateCourse = GraphQL::Relay::Mutation.define do
  name 'CreateCourse'
  description 'Эта мутация создает курс и аттачиит его к пользователю, который преподаватель.'

  input_field :cover do
    description 'Передается изображение в формате base64.'
    type types.String
  end
  input_field :description do
    description 'Здесь принимается укороченное описание курса. Нужно где-то в малеьньких сносках.'
    type !types.String
  end
  input_field :full_description do
    description 'Здесь принимается полное описание курса.'
    type types.String
  end
  input_field :is_available_for_review do
    default_value false
    description 'Отправлен ли на ревью у специалиста Buseedo курс.'
    type types.Boolean
  end
  input_field :name do
    description 'Здесь принимается наименование курса.'
    type !types.String
  end
  input_field :user_id do
    description 'Здесь принимается user_id (преподавателя). Курсу сразу ставиится галочка, что пользователь создатель курса.'
    type !types.Int
  end
  input_field :teachers do
    type types[types.Int]
  end

  return_field :course, Types::CourseType

  resolve ->(_, inputs, _) {
    user_id = inputs[:user_id]
    user = User.find(user_id)
    cover_from_inputs = inputs[:cover]

    course_hash = {
      description: inputs[:description],
      full_description: inputs[:full_description],
      is_available_for_review: inputs[:is_available_for_review],
      name: inputs[:name],
    }

    if inputs.to_h.has_key? 'cover'
      decoded_cover_data = Base64.decode64(cover_from_inputs)
      cover_data = StringIO.new(decoded_cover_data)
      course_hash[:cover] = cover_data
    end

    ActiveRecord::Base.transaction do
      course = Course.create!(course_hash)

      CourseTeacher.create!(
        course: course,
        is_creator: true,
        teacher: user
      )

      (inputs[:teachers] - [user_id]).each do |teacher_id|
        CourseTeacher.create!(
          course: course,
          user_id: teacher_id
        )
      end

      { course: course }
    end
  }
end