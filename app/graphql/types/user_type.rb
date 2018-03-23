UserType = GraphQL::ObjectType.define do
  name 'User'
  field :id, !types.ID
  field :course_users, !types[CourseUserType]
end