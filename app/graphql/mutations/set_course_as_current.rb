Mutations::SetCourseAsCurrent = GraphQL::Relay::Mutation.define do
  name 'SetCourseAsCurrent'

  input_field :continued_at, !types.Int
  input_field :id, !types.Int

  return_field :course_user, Types::CourseUserType

  resolve ->(_, inputs, _) {
    course_user = CourseUser.find(inputs[:id])
    course_user.update_attributes!(continued_at: Time.zone.at(inputs[:continued_at]), is_current: true)
    { course_user: course_user }
  }
end