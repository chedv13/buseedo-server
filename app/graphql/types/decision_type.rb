Types::DecisionType = GraphQL::ObjectType.define do
  name 'Decision'

  field :id, !types.Int
  field :body, !types.String
  field :feedback, types.String
  field :status, !types.String
  field :teacher, Types::UserType
end