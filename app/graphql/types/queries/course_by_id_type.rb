Types::Queries::CourseByIdType = GraphQL::ObjectType.define do
  field :course do
    description 'Запрос возвращает объект курса.'
    type Types::CourseType
    argument :id do
      description 'ID курса.'
      type !types.Int
    end
    resolve ->(_, args, _) {
      Course.find(args['id'])
    }
  end
end
