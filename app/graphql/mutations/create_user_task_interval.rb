Mutations::CreateUserTaskInterval = GraphQL::Relay::Mutation.define do
  name 'CreateUserTaskInterval'

  input_field :started_at, !types.Int
  input_field :user_task_id, !types.ID

  return_field :user_task_interval, Types::UserTaskIntervalType

  resolve ->(_, inputs, _) {
    user_task_interval = UserTaskInterval.new
    user_task_interval.user_task_id = inputs[:user_task_id]
    user_task_interval.started_at = Time.zone.at(inputs[:started_at])
    user_task_interval.save
    { user_task_interval: user_task_interval }
  }
end