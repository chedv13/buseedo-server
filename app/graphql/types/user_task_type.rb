Types::UserTaskType = GraphQL::ObjectType.define do
  name 'UserTask'

  field :decisions, !types[Types::DecisionType]
  field :id, !types.Int
  field :intervals, !types[Types::UserTaskIntervalType]
  field :is_completed, !types.Boolean
  field :is_current, !types.Boolean
  field :last_decision do
    type Types::DecisionType
    resolve ->(obj, _, _) {
      obj.decisions.last
    }
  end
  field :related_user_tasks do
    type !types[Types::UserTaskType]
    resolve ->(obj, _, _) {
      obj.user_day.user_tasks.where.not(id: obj.id)
    }
  end
  field :task, Types::TaskType
  field :task_id, !types.Int
  field :user_day, Types::UserDayType
  field :user_day_id, !types.Int
end