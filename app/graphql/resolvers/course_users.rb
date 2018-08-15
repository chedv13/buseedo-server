class Resolvers::CourseUsers
  def call(_, args, _)
    course_users = CourseUser.where(user_id: args['user_id']).order('is_current DESC, continued_at DESC')
    course_users = course_users.joins(:course).where("courses.name ILIKE '%#{args['q']}%'").order('courses.name DESC') if args.key? 'q'
    course_users
  end
end