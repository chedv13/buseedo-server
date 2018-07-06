Types::SkillType = GraphQL::ObjectType.define do
  name 'Skill'
  description 'Объект навыка, который приобретается при прохождении задач.'

  field :id, !types.Int
  field :name do
    description 'Наименование навыка.'
    type !types.String
  end
end