Types::Queries::CourseTeacherQueryType = GraphQL::ObjectType.define do
  connection :course_teachers, Connections::CourseTeacherConnection do
    description 'Запрос возвращает объекты CourseTeacher.'

    # add_default_args
    argument :course_id do
      description 'Если указан course_id, то отдаются все учителя данного курса.'
      type types.Int
    end
    argument :with_course_users do
      description ''
      type types.Boolean
    end
    argument :user_id do
      description 'Если указан user_id, то отдаются курсы, который ведет данный пользователь (нужно указать поле course).'
      type types.Int
    end

    resolve Resolvers::CourseTeachers.new
  end
end