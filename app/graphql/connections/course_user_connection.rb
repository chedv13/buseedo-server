Connections::CourseUserConnection = Types::CourseUserType.define_connection do
  name 'CourseUserConnection'
  description 'Возврщает объект CourseUser вместе с total_count.'

  field :total_count do
    description 'Общее количество объектов.'
    type types.Int

    resolve ->(_, _, ctx) {
      parent_args_hash = ctx.irep_node.parent.arguments.to_h

      course_users = CourseUser.all
      course_users = course_users.where(user_id: parent_args_hash['user_id']).order('is_current DESC, continued_at DESC') if parent_args_hash.key? 'user_id'
      course_users = course_users.joins(:course).where("courses.name ILIKE '%#{parent_args_hash['q']}%'").order('courses.name DESC') if parent_args_hash.key? 'q'
      course_users.count
    }
  end
end