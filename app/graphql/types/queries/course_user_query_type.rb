Types::Queries::CourseUserQueryType = GraphQL::ObjectType.define do
  connection :course_users, Connections::CourseUserConnection do
    description 'Запрос возвращает список объектов CourseUser.'

    # add_default_args
    argument :q do
      description 'Если указан этот параметр, то произойдет поиск по наименованию курса'
      type types.String
    end
    argument :user_id do
      description 'Если указан user_id, то отдаются объекты модели CourseUser на который заджойнен пользователь.'
      type types.Int
    end

    resolve Resolvers::CourseUsers.new
  end
end