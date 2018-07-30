Mutations::CreateDecision = GraphQL::Relay::Mutation.define do
  name 'CreateDecision'
  description 'Эта мутация создает решение для таски, которую выполнял пользователь.'

  input_field :body do
    description 'Здесь принимается контент решения поьзователя. По умолчанию мы считаем, что это HTML.'
    type !types.String
  end
  input_field :finished_at do
    description 'Поле обзначаюющее, когда написано решение. Если оно передано, то у последнего интервала выполнения таски, ставится оно. Принимается UNIX Timestamp.'
    type types.Int
  end
  input_field :user_task_id do
    description 'ID объекта UserTask. Нужен для того, чтобы привзять решенеие, к выполняемой пользователем задаче.'
    type !types.Int
  end

  return_field :decision, Types::DecisionType

  resolve ->(_, inputs, _) {
    user_task = UserTask.find(inputs[:user_task_id])
    decision = user_task.decisions.create!(body: inputs[:body])

    return { decision: decision } unless inputs.to_h.has_key? 'finished_at'

    finished_at = inputs[:finished_at].to_i
    if finished_at == 0
      # TODO: Здесь добавить logger.info
      return { decision: decision }
    end

    last_user_task_interval = user_task.intervals.last
    last_user_task_interval.update_column(:finished_at, Time.at(finished_at))
    { decision: decision }
  }
end