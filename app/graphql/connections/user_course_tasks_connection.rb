Connections::UserCourseTasksConnection = Types::TaskType.define_connection do
  name 'UserCourseTasksConnection'
  description 'Возвращает объекты задач для курса который проходит пользователь.'

  field :total_count do
    description 'Общее количество объектов.'
    type types.Int

    resolve ->(_, _, ctx) {
      parent_args_hash = ctx.irep_node.parent.arguments.to_h
      course_user = CourseUser.find_by(user_id: parent_args_hash['user_id'], course_id: parent_args_hash['course_id'])
      tasks = []
      if course_user
        tasks = Course.find(parent_args_hash['course_id']).tasks.where(is_published: true)
      end

      tasks.count
    }
  end

end
