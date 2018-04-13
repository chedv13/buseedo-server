Types::UserTaskType = GraphQL::ObjectType.define do
  name 'UserTask'
  field :course_user, Types::CourseUserType
  field :course_user_id, !types.Int
  field :id, !types.Int
  field :is_completed, !types.Boolean
  field :is_current, !types.Boolean
  field :task, Types::TaskType
  field :task_id, !types.Int
  field :intervals, !types[Types::UserTaskIntervalType]
end