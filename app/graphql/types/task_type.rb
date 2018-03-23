Types::TaskType = GraphQL::ObjectType.define do
  name 'Task'
  field :description, !types.String
  field :id, !types.ID
  field :name, !types.String
end