Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :courses, !types[Types::CourseType] do
    argument :excluded_user_id, types.Int, 'Если указан excluded_user_id, то из вывода исключаются курсы на который заджойнен пользователь из excluded_user_id.'
    argument :limit, types.Int, default_value: 20
    argument :order, types.String, 'Можно указывать сортировку, как ORDER в SQL. Пример: "id DESC, name ASC".'
    argument :page, types.Int, default_value: 0
    argument :q, types.String, 'Если указан этот параметр, то произойдет поиск по наименованию курса'
    argument :user_id, types.Int, 'Если указан user_id, то отдаются курсы на который заджойнен пользователь.'
    resolve ->(_, args, _) {
      offset = args[:page] * args[:limit]
      courses = Course.published

      if args.key? 'user_id'
        courses = courses.joins(:course_users).where("course_users.user_id = #{args['user_id']}")
                    .order('course_users.is_current DESC')
      end

      courses = courses.where.not(id: CourseUser.select(:course_id).where(user_id: args['excluded_user_id'])) if args.key? 'excluded_user_id'
      courses = courses.where("name ILIKE '%#{args['q']}%'").order('name DESC') if args.key? 'q'
      courses = courses.order(args['order']) if args.key? 'order'
      courses.limit(args[:limit]).offset(offset)
    }
  end

  field :course do
    type Types::CourseType
    argument :id, !types.ID
    resolve ->(_, args, _) {
      Course.find(args['id'])
    }
  end

  field :course_teachers, !types[Types::CourseTeacherType] do
    argument :limit, types.Int, default_value: 20
    argument :page, types.Int, default_value: 0
    argument :user_id, types.ID, 'Если указан user_id, то отдаются объекты модели CourseTeacher на который заджойнен пользователь.'
    resolve ->(_, args, _) {
      offset = args[:page] * args[:limit]

      course_teachers = CourseTeacher.all
      course_teachers = course_teachers.where(user_id: args['user_id']) if args.key? 'user_id'
      course_teachers.limit(args[:limit]).offset(offset)
    }
  end

  field :course_users, !types[Types::CourseUserType] do
    argument :limit, types.Int, default_value: 20
    argument :page, types.Int, default_value: 0
    argument :q, types.String, 'Если указан этот параметр, то произойдет поиск по наименованию курса'
    argument :user_id, types.ID, 'Если указан user_id, то отдаются объекты модели CourseUser на который заджойнен пользователь.'
    resolve ->(_, args, _) {
      offset = args[:page] * args[:limit]

      course_users = CourseUser.all
      course_users = course_users.where(user_id: args['user_id']) if args.key? 'user_id'
      course_users.limit(args[:limit]).offset(offset)
    }
  end

  field :users, !types[Types::UserType] do
    argument :limit, types.Int, default_value: 20
    argument :order, types.String, 'Можно указывать сортировку, как ORDER в SQL. Пример: "id DESC, name ASC".'
    argument :page, types.Int, default_value: 0
    resolve ->(_, args, _) {
      User.all
    }
  end
end
