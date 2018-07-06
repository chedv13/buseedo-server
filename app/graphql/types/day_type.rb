Types::DayType = GraphQL::ObjectType.define do
  name 'Day'
  description 'Объект дня, который ассоцииирован с курсом.'

  connection :tasks do
    description 'Связь заданий с определенным днём.'
    type Connections::TaskConnectionWithTotalCountType
  end

  field :course do
    description 'Связь с объектом курса.'
    type Types::CourseType
  end
  field :course_id do
    description 'ID курса.'
    type !types.Int
  end
  field :id, !types.Int
  field :number do
    description 'Значение, обозначающее порядковый номер дня.'
    type !types.Int
  end
end