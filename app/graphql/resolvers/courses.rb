class Resolvers::Courses
  def call(_, args, _)
    courses = Course.published.order('id DESC')

    if args.key? 'user_id'
      courses = courses.joins(:course_users).where("course_users.user_id = #{args['user_id']}")
                  .order('course_users.is_current DESC')
    end

    courses = courses.where.not(id: CourseUser.select(:course_id).where(user_id: args['excluded_user_id'])) if args.key? 'excluded_user_id'
    courses = courses.where("name ILIKE '%#{args['q']}%'").order('name DESC') if args.key? 'q'
    courses = courses.order(args['order']) if args.key? 'order'
    courses
  end
end