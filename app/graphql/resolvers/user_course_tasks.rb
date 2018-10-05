class Resolvers::UserCourseTasks
  def call(_, args, _)
    course_user = CourseUser.find_by(user_id: args[:user_id], course_id: args[:course_id])
    tasks = []
    if course_user
      tasks = Course.find(args[:course_id]).tasks.where(is_published: true)
    end

    tasks
  end
end
