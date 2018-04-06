Types::UserTaskType = GraphQL::ObjectType.define do
  name 'UserTask'
  field :id, !types.ID
  field :is_completed, !types.Boolean
  field :is_current, !types.Boolean
  field :task, Types::TaskType
  field :task_id, !types.Int
  field :course_user, Types::CourseUserType
  field :course_user_id, !types.Int
end