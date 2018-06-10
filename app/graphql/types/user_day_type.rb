Types::UserDayType = GraphQL::ObjectType.define do
  name 'UserDay'

  field :course_user, Types::CourseUserType
  field :course_user_id, !types.Int
  field :day, Types::DayType
  field :day_id, !types.Int
  field :id, !types.Int
  field :is_completed, !types.Boolean
  field :user_tasks, !types[Types::UserTaskType]
end