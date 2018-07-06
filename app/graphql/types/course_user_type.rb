Types::CourseUserType = GraphQL::ObjectType.define do
  name 'CourseUser'
  description 'Объект, обозначающий, какой пользователь заджойнен на курс.'

  field :continued_at do
    description 'Поле, обозначающее, когда курс пользователь пролжил проходить дальше.'
    type types.Int
    resolve ->(obj, _, _) {
      obj.continued_at_seconds_since_1970
    }
  end
  field :course do
    description 'Связь с объектом курса.'
    type Types::CourseType
  end
  field :course_id do
    description 'ID курса.'
    type !types.Int
  end
  field :created_at do
    description 'Когда пользователь заджойнился на курс?'
    type !types.Int
    resolve ->(obj, _, _) {
      obj.created_at_seconds_since_1970
    }
  end
  field :current_number_of_points do
    description 'Значение, обозначающее сколько пользователь заработал на данном курсе на данный момент.'
    type !types.Int
  end
  field :id, !types.Int
  field :is_completed do
    description 'Значение, обозначающее пройдет ли курс данным пользовалем.'
    type !types.Boolean
  end
  field :is_current do
    description 'Значение, обозначающее продит ли пользователь курс в данным момент.'
    type !types.Boolean
  end
  field :user do
    description 'Связь с объектом пользователя.'
    type Types::UserType
  end
  field :user_id do
    description 'ID пользователя.'
    type !types.Int
  end
end