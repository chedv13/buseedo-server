Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :courses, !types[Types::CourseType] do
    argument :excluded_user_id, types.Int
    argument :limit, types.Int, default_value: 20
    argument :order, types.String
    argument :page, types.Int, default_value: 0
    argument :user_id, types.Int
    resolve ->(_, args, _) {
      offset = args[:page] * args[:limit]
      courses = Course.published

      if args.key? 'user_id'
        courses = courses.joins(:course_users).where("course_users.user_id = #{args['user_id']}")
                    .order('course_users.is_current DESC')
      end

      courses = courses.where.not(id: CourseUser.select('id').where(user_id: 1)) if args.key? 'excluded_user_id'
      courses = courses.order(args['order']) if args.key? 'order'
      courses.limit(args[:limit]).offset(offset)
    }
  end

  field :course do
    type Types::CourseType
    argument :id, !types.ID
    resolve ->(_, args, ctx) {
      GraphQL::QueryResolver.run(Course, ctx, Types::CourseType) do
        Course.find(args['id'])
      end
    }
  end

  field :course_users, !types[CourseUserType] do
    argument :limit, types.Int, default_value: 20
    argument :page, types.Int, default_value: 0
    argument :user_id, types.ID
    resolve ->(_, args, _) {
      offset = args[:page] * args[:limit]

      course_users = CourseUser.all
      course_users = course_users.where(user_id: args['user_id']) if args.key? 'user_id'
      course_users.limit(args[:limit]).offset(offset)
    }
  end

  field :users, !types[UserType] do
    resolve ->(_, args, _) {
      User.all
    }
  end
end
