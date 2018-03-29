Mutations::CreateCourseUser = GraphQL::Relay::Mutation.define do
  name 'CreateCourseUser'

  input_field :user_id, !types.ID
  input_field :course_id, !types.ID

  return_field :course_user, Types::CourseUserType

  resolve ->(_, inputs, _) {
    course_user = CourseUser.create!(course_id: inputs[:course_id], user_id: inputs[:user_id])
    { course_user: course_user }
  }
end