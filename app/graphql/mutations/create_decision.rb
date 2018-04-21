Mutations::CreateDecision = GraphQL::Relay::Mutation.define do
  name 'CreateDecision'

  input_field :body, !types.String
  input_field :finished_at, !types.Int
  input_field :user_task_id, !types.Int

  return_field :decision, Types::DecisionType

  resolve ->(_, inputs, _) {
    user_task = UserTask.find(inputs[:user_task_id])
    decision = user_task.decisions.create!(body: inputs[:body])
    { decision: decision }
  }
end