Types::UserTaskIntervalType = GraphQL::ObjectType.define do
  name 'UserTaskInterval'
  description 'Промежуток времени, который пользователь выполнянл задачу.'

  field :finished_at do
    description 'Когда закончился промежуток времени, который пользовтель выполнял задачу. Возвращает UNIX Timestamp.'
    type types.Int
    resolve ->(obj, _, _) {
      obj.finished_at_seconds_since_1970
    }
  end
  field :id, !types.Int
  field :started_at do
    description 'Когда начался промежуток времени, который пользовтель выполнял задачу. Возвращает UNIX Timestamp.'
    type !types.Int
    resolve ->(obj, _, _) {
      obj.started_at_seconds_since_1970
    }
  end
  field :user_task do
    description 'Связь с объектом UserTask.'
    type Types::UserTaskType
  end
  field :user_task_id do
    description 'ID объекта UserTask.'
    type !types.Int
  end
end