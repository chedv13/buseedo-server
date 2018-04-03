Mutations::FinishTask = GraphQL::Relay::Mutation.define do
  name 'FinishTask'

  input_field :id, !types.ID

  return_field :user_task, Types::UserTaskType
  return_field :user_task_interval, Types::UserTaskIntervalType

  resolve ->(_, inputs, _) {
    user_task = UserTask.find(inputs[:id])
    user_task.update_attributes!(is_completed: true)
    user_task_interval = user_task.intervals.last
    {
      user_task: user_task,
      user_task_interval: user_task_interval
    }
  }
end