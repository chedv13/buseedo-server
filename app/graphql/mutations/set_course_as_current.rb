Mutations::SetCourseAsCurrent = GraphQL::Relay::Mutation.define do
  name 'SetCourseAsCurrent'
  description 'Мутация помечает курс, как текущий у пользователя.'

  input_field :continued_at do
    description 'Когда курс был продолжен. Принимает UNIX Timestamp.'
    type !types.Int
  end
  input_field :id do
    description 'ID курса.'
    type !types.Int
  end

  return_field :course_user, Types::CourseUserType

  resolve ->(_, inputs, _) {
    course_user = CourseUser.find(inputs[:id])
    course_user.update_attributes!(continued_at: Time.zone.at(inputs[:continued_at]), is_current: true)
    { course_user: course_user }
  }
end