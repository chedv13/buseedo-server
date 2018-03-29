Mutations::SetFinishedAtToUserTaskInterval = GraphQL::Relay::Mutation.define do
  name 'SetFinishedAtToUserTaskInterval'

  input_field :finished_at, !types.Int
  input_field :id, !types.ID

  return_field :user_task_interval, Types::UserTaskIntervalType

  resolve ->(_, inputs, _) {
    user_task_interval = UserTaskInterval.find(inputs[:id])
    user_task_interval.update_attributes!(finished_at: Time.zone.at(inputs[:finished_at]))
    { user_task_interval: user_task_interval }
  }
end