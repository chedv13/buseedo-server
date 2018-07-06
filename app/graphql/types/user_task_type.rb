Types::UserTaskType = GraphQL::ObjectType.define do
  name 'UserTask'
  description 'Объект, обозначающий, что пользователь проходит задание.'

  field :decisions do
    description 'Решения, закрепленные за данным объектом.'
    type !types[Types::DecisionType]
  end
  field :id, !types.Int
  field :intervals do
    description 'Промежутки выполнения пользователем задания.'
    type !types[Types::UserTaskIntervalType]
  end
  field :is_completed do
    description 'Значение, обозначающее выполнил ли пользователь задание.'
    type !types.Boolean
  end
  field :is_current do
    description 'Значение, обозначающее выполняет ли пользователь задание в данный момент.'
    type !types.Boolean
  end
  field :last_decision do
    description 'Объект последнего решения, который пользователь отправил, решая задание.'
    type Types::DecisionType
    resolve ->(obj, _, _) {
      obj.decisions.last
    }
  end
  field :related_user_tasks do
    description 'Остальные задачи, который выполнял пользователь, относящиеся к текущему дню.'
    type !types[Types::UserTaskType]
    resolve ->(obj, _, _) {
      obj.user_day.user_tasks.where.not(id: obj.id)
    }
  end
  field :task do
    description 'Связь с объектом задачи.'
    type Types::TaskType
  end
  field :task_id do
    description 'ID задачи.'
    type !types.Int
  end
  field :user_day do
    description 'Связь с объектом UserDay.'
    type Types::UserDayType
  end
  field :user_day_id do
    description 'ID объекта UserDay.'
    type !types.Int
  end
end