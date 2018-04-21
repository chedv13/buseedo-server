Types::TaskType = GraphQL::ObjectType.define do
  name 'Task'
  field :body, !types.String
  field :day, Types::DayType
  field :id, !types.Int
  field :name, !types.String
  field :number_of_percentages, !types.Int
  field :number_of_points, !types.Int
  field :serial_number, !types.Int
  field :skills, !types[Types::SkillType]
end