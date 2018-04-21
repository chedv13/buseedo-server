Types::DecisionType = GraphQL::ObjectType.define do
  name 'Decision'
  field :id, !types.Int
  field :body, !types.String
end