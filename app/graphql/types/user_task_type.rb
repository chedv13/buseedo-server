Types::UserTaskType = GraphQL::ObjectType.define do
  name 'UserTask'
  field :id, !types.ID
  field :is_completed, !types.Boolean
  field :is_current, !types.Boolean
  field :task, Types::TaskType
  field :task_id, !types.ID
  field :user, Types::UserType
  field :user_id, !types.ID
end