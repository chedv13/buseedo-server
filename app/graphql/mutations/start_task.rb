Mutations::StartTask = GraphQL::Relay::Mutation.define do
  name 'StartTask'
  description 'Мутация возобновляет выполнение задачи.'

  input_field :started_at do
    description 'Когда было возобновлено выполнение задачи. Принимает UNIX Timestamp.'
    type !types.Int
  end
  input_field :user_task_id do
    description 'ID объекта UserTask.'
    type !types.ID
  end

  return_field :user_task_interval, Types::UserTaskIntervalType

  resolve ->(_, inputs, _) {
    user_task_interval = UserTaskInterval.new
    user_task_interval.started_at = Time.zone.at(inputs[:started_at])
    user_task_interval.user_task_id = inputs[:user_task_id]
    user_task_interval.save
    { user_task_interval: user_task_interval }
  }
end