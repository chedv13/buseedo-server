Types::DecisionType = GraphQL::ObjectType.define do
  name 'Decision'
  description 'Решение, которое пользователь закрепил за задачей.'

  field :body do
    description 'Тело решения задачи. Может быть в HTML.'
    type !types.String
  end
  field :feedback do
    description 'Фидбек преподавателя. Может быть в HTML.'
    type types.String
  end
  field :id, !types.Int
  field :status do
    description "Статус решения. Можем быть: #{Decision.statuses.keys}. 'pending' - решение ещё не проверено преподавателем. 'verified' - преподаватель счёл решение правильным. 'failed' - преподаватель счёл решение неправильным."
    type !types.String
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