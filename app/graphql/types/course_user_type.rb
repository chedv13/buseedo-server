CourseUserType = GraphQL::ObjectType.define do
  name 'CourseUser'

  field :course, Types::CourseType
  field :course_id, !types.Int
  field :id, !types.ID
  field :is_completed, !types.Boolean
  field :is_current, !types.Boolean
  field :user, UserType
  field :user_id, !types.Int
end