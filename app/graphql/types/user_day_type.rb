Types::UserDayType = GraphQL::ObjectType.define do
  name 'UserDay'
  description 'Объект, обозначающий, что пользователь проходит таски какого-то определенный дня в курсе.'

  field :course_user do
    description 'Связь с объектом CourseUser.'
    type Types::CourseUserType
  end
  field :course_user_id do
    description 'ID объекта CourseUser.'
    type !types.Int
  end
  field :day do
    description 'Связь с объектом дня.'
    type Types::DayType
  end
  field :day_id do
    description 'ID дня.'
    type !types.Int
  end
  field :id, !types.Int
  field :is_completed do
    description 'Значение, обозначающее пройдены ли все таски за данный день пользователем.'
    type !types.Boolean
  end
  field :started_at do
    description 'Значение, обозначающее, когда бьло начато прохождение задач данного дня. Возвращает UNIX Timestamp.'
    type !types.Int
    resolve ->(obj, _, _) {
      obj.started_at_seconds_since_1970
    }
  end
  field :status do
    description 'Статус дня. Если у пользователя хотя бы одно решение за данный день помечено, как "failed", то отдается "failed". Если все таски за данный день пройдены и они все "verified", то отдается "verified". В ином случае отдается "pending".'
    type !types.String
    resolve ->(obj, _, _) {
      obj.status
    }
  end
  field :user_tasks do
    description 'Объекты UserTasks. Обозанчают какие таски сейчас проходит пользователь за даннный день.'
    type !types[Types::UserTaskType]
  end
end