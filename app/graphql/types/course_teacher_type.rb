Types::CourseTeacherType = GraphQL::ObjectType.define do
  name 'CourseTeacher'
  description 'Объект, обозначающий связь курса с преподавателем.'

  field :course do
    description 'Связь с объектом курса.'
    type Types::CourseType
  end
  field :course_id do
    description 'ID курса.'
    type !types.Int
  end
  field :id, !types.Int
  field :is_creator do
    description 'Значение, обозначающее создал ли этот курса данный преподаватель?'
    type !types.Boolean
  end
  field :teacher do
    description 'Связь с объектом преподавателя курса.'
    type Types::UserType
  end
  field :user_id do
    description 'ID преподавателя курса.'
    type !types.Int
  end
end