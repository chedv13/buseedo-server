Types::Queries::CourseQueryType = GraphQL::ObjectType.define do
  connection :courses, Connections::CourseConnection do
    description 'Запрос возвращает объекты курсов.'

    # add_default_args
    argument :excluded_user_id do
      description 'Если указан excluded_user_id, то из вывода исключаются курсы на который заджойнен пользователь из excluded_user_id.'
      type types.Int
    end
    argument :q do
      description 'Если указан этот параметр, то произойдет поиск по наименованию курса.'
      type types.String
    end
    argument :user_id do
      description 'Если указан user_id, то отдаются курсы на который заджойнен пользователь.'
      type types.Int
    end

    resolve Resolvers::Courses.new
  end
end
