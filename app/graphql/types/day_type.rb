# require '../connections/task_connection_with_total_count_type'

Types::DayType = GraphQL::ObjectType.define do
  name 'Day'

  connection :tasks, Connections::TaskConnectionWithTotalCountType

  field :id, !types.Int
  field :number, !types.Int
end