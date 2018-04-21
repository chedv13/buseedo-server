Types::UserTaskType = GraphQL::ObjectType.define do
  name 'UserTask'
  field :course_user, Types::CourseUserType
  field :course_user_id, !types.Int
  field :id, !types.Int
  field :intervals, !types[Types::UserTaskIntervalType]
  field :is_completed, !types.Boolean
  field :is_current, !types.Boolean
  field :related_user_tasks do
    type !types[Types::UserTaskType]
    resolve ->(obj, _, _) {
      UserTask.all.joins(task: %i[day]).where(
        "days.id = #{obj.task.day.id} and course_user_id = #{obj.course_user_id} and user_tasks.id != #{obj.id}"
      )
    }
  end
  field :task, Types::TaskType
  field :task_id, !types.Int
end