Types::UserDayType = GraphQL::ObjectType.define do
  name 'UserDay'

  field :course_user, Types::CourseUserType
  field :course_user_id, !types.Int
  field :day, Types::DayType
  field :day_id, !types.Int
  field :id, !types.Int
  field :is_completed, !types.Boolean
  field :started_at do
    type !types.Int
    resolve ->(obj, _, _) {
      obj.started_at_seconds_since_1970
    }
  end
  field :status do
    type !types.String
    resolve ->(obj, _, _) {
      obj.status
    }
  end
  field :user_tasks, !types[Types::UserTaskType]
end