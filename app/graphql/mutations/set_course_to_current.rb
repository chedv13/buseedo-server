Mutations::SetCourseToCurrent = GraphQL::Relay::Mutation.define do
  name "SetCourseToCurrent"

  input_field :id, !types.ID

  return_field :course_user, Types::CourseUserType

  resolve ->(_, inputs, _) {
    course_user = CourseUser.find(inputs[:id])
    course_user.update_attributes!(is_current: true)
    { course_user: course_user }
  }
end