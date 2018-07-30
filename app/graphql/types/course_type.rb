Types::CourseType = GraphQL::ObjectType.define do
  name 'Course'
  description 'Объект курса.'

  connection :days do
    description 'Связь дней с курсом.'
    type Connections::DayConnectionWithTotalCountType
  end

  field :background_image_url do
    description 'Это поле предназначено для того, чтобы в ios-версии (и возможно где-то еще) вставлять изображение позади описания курса.'
    type !types.String
    argument :style, types.String, "Possible styles: #{Course.cover_styles_hash}. Arguments are keys of hash."
    resolve ->(obj, args, ctx) {
      obj.full_attachment_url(ctx.to_h[:request].base_url, 'background_image', args['style'])
    }
  end
  field :cover_url do
    description 'Иконка курса.'
    type !types.String
    argument :style, types.String, "Possible styles: #{Course.cover_styles_hash}. Arguments are keys of hash."
    resolve ->(obj, args, ctx) {
      obj.full_attachment_url(ctx.to_h[:request].base_url, 'cover', args['style'])
    }
  end
  field :description do
    description 'Краткое текстовое описание курса. Нужно для того, чтобы первично ознакомиться с курсом.'
    type types.String
  end
  field :final_number_of_points do
    description 'Количество баллов, котороые можно получить за прохождение данного курса (в общем, нужно в скиллах и для определениия левела пользователя в будущем).'
    type !types.Int
  end
  field :full_description do
    description 'Полное текстовое описание курса. Возможно в HTML.'
    type types.String
  end
  field :id, !types.Int
  field :name do
    description 'Наименование курса.'
    type !types.String
  end
  field :course_teachers do
    description 'Здесь мы получаем связь course_teachers, через которую можем достучаться до преподавателей курса.'
    type !types[Types::CourseTeacherType]
  end
end