Types::SkillType = GraphQL::ObjectType.define do
  name 'Skill'
  field :id, !types.Int
  field :name, !types.String
end