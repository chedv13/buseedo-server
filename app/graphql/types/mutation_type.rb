Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  field :createCourseUser, field: Mutations::CreateCourseUser.field
  field :createUserTaskInterval, field: Mutations::CreateUserTaskInterval.field
  field :setCourseToCurrent, field: Mutations::SetCourseToCurrent.field
  field :setFinishedAtToUserTaskInterval, field: Mutations::SetFinishedAtToUserTaskInterval.field
end
