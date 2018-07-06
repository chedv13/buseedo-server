Mutations::JoinCourse = GraphQL::Relay::Mutation.define do
  name 'JoinCourse'

  input_field :user_id do
    description 'ID пользователя, который джойнится к курсу'
    type !types.Int
  end
  input_field :course_id do
    description 'ID курса, к которому джойнится пользователь'
    type !types.ID
  end

  return_field :course_user, Types::CourseUserType

  resolve ->(_, inputs, _) {
    course_user = CourseUser.create!(course_id: inputs[:course_id], user_id: inputs[:user_id])
    { course_user: course_user }
  }
end