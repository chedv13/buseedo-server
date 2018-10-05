Types::Queries::UserCourseTasks = GraphQL::ObjectType.define do
  connection :user_course_tasks, Connections::UserCourseTasksConnection do
    description 'Запрос возвращает объекты задач.'

    # add_default_args
    argument :course_id do
      description 'По course_id возвращаются задачи принадлежащие этому курсу.'
      type !types.Int
    end
    argument :user_id do
      description 'По user_id возвращаются курсы к которым присоединился пользователь.'
      type !types.Int
    end

    resolve Resolvers::UserCourseTasks.new
  end
end
