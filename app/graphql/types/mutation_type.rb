Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  field :createCourseUser, field: Mutations::CreateCourseUser.field
  field :finishTask, field: Mutations::FinishTask.field
  field :pauseTask, field: Mutations::PauseTask.field
  field :setCourseToCurrent, field: Mutations::SetCourseToCurrent.field
  field :startTask, field: Mutations::StartTask.field
end
