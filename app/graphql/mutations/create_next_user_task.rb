Mutations::CreateNextUserTask = GraphQL::Relay::Mutation.define do
  name 'CreateNextUserTask'

  input_field :user_task_id, !types.Int

  return_field :user_task, Types::DecisionType

  resolve ->(_, inputs, _) {
    user_task_id = inputs[:user_task_id]
    current_user_task = UserTask.find(user_task_id)
    next_task = current_user_task.day.tasks.where("id > #{user_task_id}").first
    user_task = UserTask.create!(course_user: current_user_task.course_user, task: next_task)
    { user_task: user_task }
  }
end