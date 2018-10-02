Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createCourse, function: Resolvers::CreateCourse.new
  field :createCourseDays, function: Resolvers::CreateCourseDays.new
  field :createDecision, field: Mutations::CreateDecision.field
  field :createTask, function: Resolvers::CreateTask.new
  field :joinCourse, field: Mutations::JoinCourse.field
  field :pauseTask, field: Mutations::PauseTask.field
  field :setCourseAsCurrent, field: Mutations::SetCourseAsCurrent.field
  field :startTask, field: Mutations::StartTask.field
  field :updateCourse, function: Resolvers::UpdateCourse.new
  field :updateTask, function: Resolvers::UpdateTask.new
  field :updateUser, field: Mutations::UpdateUser.field
  field :deleteTask, function: Resolvers::DeleteTask.new
end
