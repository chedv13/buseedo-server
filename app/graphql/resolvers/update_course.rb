class Resolvers::UpdateCourse < Resolvers::CourseMutation
  description 'Эта мутация обновляет курс и аттачиит его к пользователю, который преподаватель.'

  argument :cover do
    description 'Передается изображение в формате base64.'
    type types.String
  end
  argument :description do
    description 'Здесь принимается укороченное описание курса. Нужно где-то в малеьньких сносках.'
    type types.String
  end
  argument :full_description do
    description 'Здесь принимается полное описание курса.'
    type types.String
  end
  argument :id do
    description 'ID курса.'
    type !types.Int
  end
  argument :is_available_for_review do
    default_value false
    description 'Отправлен ли на ревью у специалиста Buseedo курс.'
    type types.Boolean
  end
  argument :name do
    description 'Здесь принимается наименование курса.'
    type types.String
  end
  argument :user_id do
    description 'Здесь принимается user_id (преподавателя). Курсу сразу ставиится галочка, что пользователь создатель курса.'
    type types.Int
  end
  argument :teachers do
    type types[types.Int]
  end

  def call(_obj, args, _ctx)
    user_id, course_hash = create_course_hash_and_find_user(args)

    ActiveRecord::Base.transaction do
      course = Course.find(args[:id])
      course.update_attributes!(course_hash)
      current_teacher_ids = course.teachers.map(&:id)
      # teacher_ids = args[:teachers] || []
      course_teachers = course.course_teachers

      # course_teachers.where(user_id: (current_teacher_ids - teacher_ids)).destroy_all
      creator_course_teacher = course_teachers.where(is_creator: true).first
      Rails.logger.info(course_teachers.where(is_creator: true).inspect)
      Rails.logger.info(creator_course_teacher.inspect)
      creator_user_id = if (user_id && user_id == creator_course_teacher.user_id) || !user_id
                          creator_course_teacher.user_id
                        else
                          creator_course_teacher.update_column(:is_creator, false)
                          new_creator_course_teachers = course_teachers.where(user_id: user_id)

                          if new_creator_course_teachers.empty?
                            new_creator_course_teachers.update_all(is_creator: true)
                          else
                            course_teachers.create!(is_creator: true, user_id: user_id)
                          end

                          user_id
                        end

      # (teacher_ids - current_teacher_ids) - [creator_user_id].each do |teacher_id|
      #   course_teachers.create!(user_id: teacher_id)
      # end

      course
    end
  end
end
