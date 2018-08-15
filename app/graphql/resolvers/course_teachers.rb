class Resolvers::CourseTeachers
  def call(_, args, _)
    course_teachers = CourseTeacher.all
    course_teachers = course_teachers.where(course_id: args['course_id']) if args.key? 'course_id'
    course_teachers = course_teachers.where(user_id: args['user_id']) if args.key? 'user_id'

    if args.key? 'user_id_from_course_users'
      course_teachers = course_teachers.joins(
        "LEFT outer join course_users ON course_teachers.course_id = course_users.course_id AND course_users.user_id = #{args['user_id_from_course_users']}"
      ).select('current_number_of_points')
    end

    course_teachers
  end
end