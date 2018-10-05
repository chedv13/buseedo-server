Types::QueryType = GraphQL::ObjectType.new.tap do |root_type|
  root_type.name = "Query"
  root_type.description = "The query root of this schema"
  root_type.interfaces = []
  root_type.fields = [
    Types::Queries::CourseByIdType,
    Types::Queries::CourseQueryType,
    Types::Queries::CourseTeacherQueryType,
    Types::Queries::CourseUserQueryType,
    Types::Queries::UserCourseTasks
  ].inject({}) do |acc, query_type|
    acc.merge!(query_type.fields)
  end
end

# TODO: Этот файл скоро разрастется. Нужен рефакторинг
# Types::QueryType = GraphQL::ObjectType.define do
#   name 'Query'
#
# field :course do
#   description 'Запрос возвращает объект курса.'
#   type Types::CourseType
#   argument :id do
#     description 'ID курса.'
#     type !types.Int
#   end
#   resolve ->(_, args, _) {
#     Course.find(args['id'])
#   }
# end
#
# field :user_day do
#   description 'Запрос возвращает объект UserDay.'
#   type Types::UserDayType
#
#   argument :id do
#     description 'Если указан этот аргумент, то запрос возвращает объект UserDay c id из этого аргумента.'
#     type types.Int
#   end
#   argument :course_user_id do
#     description 'Если указан этот аргумент, то запрос изет объект с course_user_id и started_at (при условии, что не указан аргумент id).'
#     type types.Int
#   end
#   argument :started_at do
#     description 'started_at принимается в формате "1970-01-01" вместе с course_user_id и означает, когда был начат UserDay.'
#     type types.String
#   end
#
#   resolve ->(_, args, _) {
#     if args.key?('id')
#       UserDay.find(args['id'])
#     else
#       UserDay.find_by("course_user_id = #{args['course_user_id']} AND started_at :: DATE = '#{args['started_at']}'")
#     end
#   }
# end
#
# field :user_days, !types[Types::UserDayType] do
#   description 'Запрос возвращает список объектов UserDay.'
#
#   add_default_args
#   argument :course_user_id do
#     description 'Если передается course_user_id, то выбираются объекты UserDay, которые присоединены к CourseUser..'
#     type types.Int
#   end
#   argument :month do
#     description 'Если передается month и year, то мы выбираем объекты UserDay за определенный месяц и год. month и year должны передаваться вместе.'
#     type types.Int
#   end
#   argument :year do
#     description 'Если передается month и year, то мы выбираем объекты UserDay за определенный месяц и год. month и year должны передаваться вместе.'
#     type types.Int
#   end
#
#   resolve ->(_, args, _) {
#     offset = args[:page] * args[:limit]
#
#     user_days = UserDay.all
#     user_days = user_days.where(course_user_id: args['course_user_id']) if args.key? 'course_user_id'
#
#     if args.key?('month') && args.key?('year')
#       user_days = user_days.where("EXTRACT(MONTH FROM started_at) = #{args['month']} AND EXTRACT(YEAR FROM started_at) = #{args['year']}")
#     end
#
#     user_days.limit(args[:limit]).offset(offset)
#   }
# end
#
# field :user_task do
#   description 'Запрос возвращает объект UserTask.'
#   type Types::UserTaskType
#   argument :id do
#     description 'ID объекта UserTask.'
#     type !types.Int
#   end
#   resolve ->(_, args, _) {
#     UserTask.find(args['id'])
#   }
# end
#
# field :user_tasks, !types[Types::UserTaskType] do
#   description 'Запрос возвращает объекты UserTask.'
#
#   add_default_args
#   argument :course_user_id do
#     description 'Если указан этот аргумент, то присоединяется объект UserDay, у которого course_user_id из аргументов.'
#     type types.Int
#   end
#
#   resolve ->(_, args, _) {
#     offset = args[:page] * args[:limit]
#
#     user_tasks = UserTask.all
#     user_tasks = user_tasks.joins(:user_day).where("user_days.course_user_id = #{args['course_user_id']}") if args.key? 'course_user_id'
#     user_tasks = user_tasks.order(args['order']) if args.key? 'order'
#     user_tasks.limit(args[:limit]).offset(offset)
#   }
# end
#
# field :users, !types[Types::UserType] do
#   description 'Запрос возвращает список пользователей.'
#
#   add_default_args
#
#   resolve ->(_, args, ctx) {
#     offset = args[:page] * args[:limit]
#
#     users = User.all
#     users = users.order(args['order']) if args.key? 'order'
#     users.limit(args[:limit]).offset(offset)
#   }
# end
# end

# def add_default_args
#   argument :order do
#     description 'Можно указывать сортировку, как ORDER в SQL. Пример: "id DESC, name ASC".'
#     type types.String
#   end
# end
