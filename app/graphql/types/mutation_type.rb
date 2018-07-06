Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createCourseUser, field: Mutations::JoinCourse.field
  field :createDecision, field: Mutations::CreateDecision.field
  field :pauseTask, field: Mutations::PauseTask.field
  field :setCourseAsCurrent, field: Mutations::SetCourseAsCurrent.field
  field :startTask, field: Mutations::StartTask.field
end
