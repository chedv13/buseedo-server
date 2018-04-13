# TODO: Этот файл скоро разрастется. Нужен рефакторинг
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
    argument :course_id, types.ID, 'Если указан course_id, то отдаются все учителя данного курса.'
    argument :limit, types.Int, default_value: 20
    argument :page, types.Int, default_value: 0
    argument :with_course_users, types.Boolean
    argument :user_id, types.ID, 'Если указан user_id, то отдаются курсы, который ведет данный пользователь (нужно указать поле course).'
    resolve ->(_, args, _) {
      offset = args[:page] * args[:limit]

      course_teachers = CourseTeacher.all
      course_teachers = course_teachers.where(course_id: args['course_id']) if args.key? 'course_id'
      course_teachers = course_teachers.where(user_id: args['user_id']) if args.key? 'user_id'

      if args.key? 'user_id_from_course_users'
        course_teachers = course_teachers.joins(
          "LEFT outer join course_users ON course_teachers.course_id = course_users.course_id AND course_users.user_id = #{args['user_id_from_course_users']}"
        ).select('current_number_of_points')
      end

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

  field :user_task do
    type Types::UserTaskType
    argument :id, !types.Int
    resolve ->(_, args, _) {
      UserTask.find(args['id'])
    }
  end

  field :user_tasks, !types[Types::UserTaskType] do
    argument :course_user_id, types.Int
    argument :limit, types.Int, default_value: 20
    argument :page, types.Int, default_value: 0
    resolve ->(_, args, _) {
      offset = args[:page] * args[:limit]

      user_tasks = UserTask.all
      user_tasks = user_tasks.where(course_user_id: args['course_user_id']) if args.key? 'course_user_ud'
      user_tasks.limit(args[:limit]).offset(offset)
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
