Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createCourse, function: Resolvers::CreateCourse.new
  field :createDecision, field: Mutations::CreateDecision.field
  field :joinCourse, field: Mutations::JoinCourse.field
  field :pauseTask, field: Mutations::PauseTask.field
  field :setCourseAsCurrent, field: Mutations::SetCourseAsCurrent.field
  field :startTask, field: Mutations::StartTask.field
  field :updateCourse, function: Resolvers::UpdateCourse.new
  field :updateUser, field: Mutations::UpdateUser.field
end
