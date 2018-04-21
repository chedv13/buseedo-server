Types::CourseUserType = GraphQL::ObjectType.define do
  name 'CourseUser'

  field :continued_at do
    type types.Int
    resolve ->(obj, _, _) {
      obj.continued_at_seconds_since_1970
    }
  end
  field :course, Types::CourseType
  field :course_id, !types.Int
  field :created_at do
    type !types.Int
    resolve ->(obj, _, _) {
      obj.created_at_seconds_since_1970
    }
  end
  field :current_number_of_points, !types.Int
  field :id, !types.Int
  field :is_completed, !types.Boolean
  field :is_current, !types.Boolean
  field :user, Types::UserType
  field :user_id, !types.Int
end