Types::CourseTeacherType = GraphQL::ObjectType.define do
  name 'CourseTeacher'

  field :course, Types::CourseType
  field :course_id, !types.Int
  field :id, !types.Int
  field :is_creator, !types.Boolean
  field :teacher, Types::UserType
  field :user_id, !types.Int
end