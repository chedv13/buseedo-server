Mutations::PauseTask = GraphQL::Relay::Mutation.define do
  name 'PauseTask'
  description 'Мутация ставит выполнение задачи на паузу.'

  input_field :finished_at do
    description 'Когда ставится выполнение задачи на паузу. Принимается UNIX Timestamp.'
    type !types.Int
  end
  input_field :id do
    description 'ID объекта UserTaskInterval.'
    type !types.ID
  end

  return_field :user_task_interval, Types::UserTaskIntervalType

  resolve ->(_, inputs, _) {
    user_task_interval = UserTaskInterval.find(inputs[:id])
    user_task_interval.update_attributes!(finished_at: Time.zone.at(inputs[:finished_at]))
    { user_task_interval: user_task_interval }
  }
end