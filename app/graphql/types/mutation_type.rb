Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createCourseUser, field: Mutations::CreateCourseUser.field
  field :createDecision, field: Mutations::CreateDecision.field
  field :createNextUserTask, field: Mutations::CreateNextUserTask.field
  field :finishTask, field: Mutations::FinishTask.field
  field :pauseTask, field: Mutations::PauseTask.field
  field :setCourseAsCurrent, field: Mutations::SetCourseAsCurrent.field
  field :startTask, field: Mutations::StartTask.field
end
