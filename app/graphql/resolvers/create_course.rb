class Resolvers::CreateCourse < Resolvers::CourseMutation
  description 'Эта мутация создает курс и аттачиит его к пользователю, который преподаватель.'

  argument :cover do
    description 'Передается изображение в формате base64.'
    type types.String
  end
  argument :description do
    description 'Здесь принимается укороченное описание курса. Нужно где-то в малеьньких сносках.'
    type !types.String
  end
  argument :full_description do
    description 'Здесь принимается полное описание курса.'
    type types.String
  end
  argument :name do
    description 'Здесь принимается наименование курса.'
    type !types.String
  end
  argument :user_id do
    description 'Здесь принимается user_id (преподавателя). Курсу сразу ставиится галочка, что пользователь создатель курса.'
    type !types.Int
  end
  argument :teacher_ids do
    type types[types.Int]
  end


  def call(_obj, args, _ctx)
    user_id, course_hash = create_course_hash_and_find_user(args)

    ActiveRecord::Base.transaction do
      course = Course.create!(course_hash)
      teacher_ids = args[:teacher_ids]

      CourseTeacher.create!(
        course: course,
        is_creator: true,
        user_id: user_id
      )

      if teacher_ids
        (teacher_ids - [user_id]).each do |teacher_id|
          CourseTeacher.create!(
            course: course,
            user_id: teacher_id
          )
        end
      end
      course
    end
  end
end